package com.thumbnailer.reader;

import com.thumbnailer.model.MeshModel;
import com.thumbnailer.model.Triangle;
import com.thumbnailer.model.Vector3;

import javax.xml.XMLConstants;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamConstants;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;
import java.awt.Color;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

/**
 * Reader for 3D Manufacturing Format (.3mf) archives.
 * Supports OPC relationship discovery, indexed meshes, component instancing,
 * 3D affine transforms, production extension external model parts (p:path),
 * and basic material/color groups.
 */
public class ThreeMfReader {

    private static final String REL_3D_MODEL = "http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel";
    private static final String PROD_NS = "http://schemas.microsoft.com/3dmanufacturing/production/2015/06";
    private static final String DEFAULT_MODEL_PATH = "3D/3dmodel.model";
    private static final Pattern WHITESPACE_PATTERN = Pattern.compile("\\s+");
    private static final int MAX_COMPONENT_DEPTH = 64;

    public static MeshModel read(File file) throws IOException {
        if (!file.exists()) {
            throw new IOException("File does not exist: " + file.getAbsolutePath());
        }

        try (ZipFile zipFile = new ZipFile(file)) {
            XMLInputFactory xmlFactory = createSafeXmlFactory();
            String rootModelPath = findRootModelPath(zipFile, xmlFactory);
            Map<String, ParsedModel> modelCache = new HashMap<>();

            ParsedModel rootModel = loadModel(zipFile, xmlFactory, rootModelPath, modelCache);
            List<Triangle> triangles = new ArrayList<>();
            Set<String> activeStack = new HashSet<>();

            for (BuildItem item : rootModel.buildItems()) {
                String targetPath = resolveTargetPath(rootModelPath, item.externalPath());
                collectObjectTriangles(
                        zipFile, xmlFactory, modelCache,
                        targetPath, item.objectId(), item.transform(),
                        triangles, activeStack, 0
                );
            }

            if (triangles.isEmpty()) {
                throw new IOException("No triangles found in 3MF file: " + file.getName());
            }

            return MeshModel.of(triangles);
        } catch (XMLStreamException e) {
            throw new IOException("Failed to parse XML in 3MF file: " + file.getName(), e);
        }
    }

    private static XMLInputFactory createSafeXmlFactory() {
        XMLInputFactory factory = XMLInputFactory.newInstance();
        factory.setProperty(XMLInputFactory.SUPPORT_DTD, Boolean.FALSE);
        factory.setProperty(XMLInputFactory.IS_SUPPORTING_EXTERNAL_ENTITIES, Boolean.FALSE);
        try {
            factory.setProperty(XMLConstants.ACCESS_EXTERNAL_DTD, "");
            factory.setProperty(XMLConstants.ACCESS_EXTERNAL_SCHEMA, "");
        } catch (IllegalArgumentException ignored) {
            // Some StAX implementations do not recognize JAXP access properties
        }
        return factory;
    }

    private static String findRootModelPath(ZipFile zipFile, XMLInputFactory xmlFactory)
            throws IOException, XMLStreamException {
        ZipEntry relsEntry = findZipEntry(zipFile, "_rels/.rels");
        if (relsEntry != null) {
            try (InputStream is = zipFile.getInputStream(relsEntry)) {
                XMLStreamReader reader = xmlFactory.createXMLStreamReader(is);
                while (reader.hasNext()) {
                    if (reader.next() == XMLStreamConstants.START_ELEMENT
                            && "Relationship".equals(reader.getLocalName())) {
                        String type = getAttr(reader, "Type");
                        String target = getAttr(reader, "Target");
                        if (type != null && target != null
                                && (REL_3D_MODEL.equals(type) || type.endsWith("/3dmodel"))) {
                            return normalizeZipPath(target);
                        }
                    }
                }
            }
        }

        if (findZipEntry(zipFile, DEFAULT_MODEL_PATH) != null) {
            return DEFAULT_MODEL_PATH;
        }

        Enumeration<? extends ZipEntry> entries = zipFile.entries();
        while (entries.hasMoreElements()) {
            ZipEntry entry = entries.nextElement();
            if (!entry.isDirectory() && entry.getName().toLowerCase(Locale.ROOT).endsWith(".model")) {
                return normalizeZipPath(entry.getName());
            }
        }

        throw new IOException("No 3D model part found inside 3MF archive");
    }

    private static ParsedModel loadModel(
            ZipFile zipFile,
            XMLInputFactory xmlFactory,
            String modelPath,
            Map<String, ParsedModel> cache
    ) throws IOException, XMLStreamException {
        String normalized = normalizeZipPath(modelPath);
        ParsedModel cached = cache.get(normalized);
        if (cached != null) {
            return cached;
        }

        ZipEntry entry = findZipEntry(zipFile, normalized);
        if (entry == null) {
            throw new IOException("Referenced 3MF model entry not found: " + normalized);
        }

        try (InputStream is = zipFile.getInputStream(entry)) {
            ParsedModel parsed = parseModelXml(xmlFactory, is);
            cache.put(normalized, parsed);
            return parsed;
        }
    }

    private static ParsedModel parseModelXml(XMLInputFactory xmlFactory, InputStream is)
            throws XMLStreamException, IOException {
        XMLStreamReader reader = xmlFactory.createXMLStreamReader(is);

        double unitScale = 1.0;
        Map<String, List<Color>> materials = new HashMap<>();
        Map<String, ModelObject> objects = new HashMap<>();
        List<BuildItem> buildItems = new ArrayList<>();

        String currentMaterialId = null;
        List<Color> currentColors = null;

        String currentObjectId = null;
        String currentObjectPid = null;
        int currentObjectPindex = -1;
        List<Vector3> currentVertices = null;
        List<RawTriangle> currentTriangles = null;
        List<ComponentRef> currentComponents = null;
        boolean inMesh = false;

        while (reader.hasNext()) {
            int event = reader.next();
            if (event == XMLStreamConstants.START_ELEMENT) {
                String tag = reader.getLocalName();
                switch (tag) {
                    case "model" -> unitScale = parseUnitScale(getAttr(reader, "unit"));
                    case "basematerials", "colorgroup" -> {
                        currentMaterialId = getAttr(reader, "id");
                        currentColors = new ArrayList<>();
                    }
                    case "base" -> {
                        if (currentColors != null) {
                            currentColors.add(parseHexColor(getAttr(reader, "displaycolor")));
                        }
                    }
                    case "color" -> {
                        if (currentColors != null) {
                            currentColors.add(parseHexColor(getAttr(reader, "color")));
                        }
                    }
                    case "object" -> {
                        currentObjectId = getAttr(reader, "id");
                        currentObjectPid = getAttr(reader, "pid");
                        currentObjectPindex = parseOptionalInt(getAttr(reader, "pindex"), -1);
                        currentVertices = null;
                        currentTriangles = null;
                        currentComponents = null;
                    }
                    case "mesh" -> {
                        inMesh = true;
                        currentVertices = new ArrayList<>();
                        currentTriangles = new ArrayList<>();
                    }
                    case "vertex" -> {
                        if (inMesh && currentVertices != null) {
                            double x = parseRequiredDouble(getAttr(reader, "x"), "vertex x") * unitScale;
                            double y = parseRequiredDouble(getAttr(reader, "y"), "vertex y") * unitScale;
                            double z = parseRequiredDouble(getAttr(reader, "z"), "vertex z") * unitScale;
                            currentVertices.add(new Vector3(x, y, z));
                        }
                    }
                    case "triangle" -> {
                        if (inMesh && currentTriangles != null) {
                            int v1 = parseRequiredInt(getAttr(reader, "v1"), "triangle v1");
                            int v2 = parseRequiredInt(getAttr(reader, "v2"), "triangle v2");
                            int v3 = parseRequiredInt(getAttr(reader, "v3"), "triangle v3");
                            String pid = getAttr(reader, "pid");
                            int p1 = parseOptionalInt(getAttr(reader, "p1"), -1);
                            currentTriangles.add(new RawTriangle(v1, v2, v3, pid, p1));
                        }
                    }
                    case "components" -> currentComponents = new ArrayList<>();
                    case "component" -> {
                        if (currentComponents != null) {
                            String objId = getAttr(reader, "objectid");
                            String extPath = getPathAttr(reader);
                            Transform3D transform = Transform3D.parse(getAttr(reader, "transform"), unitScale);
                            if (objId != null) {
                                currentComponents.add(new ComponentRef(objId, extPath, transform));
                            }
                        }
                    }
                    case "item" -> {
                        String objId = getAttr(reader, "objectid");
                        String extPath = getPathAttr(reader);
                        Transform3D transform = Transform3D.parse(getAttr(reader, "transform"), unitScale);
                        if (objId != null) {
                            buildItems.add(new BuildItem(objId, extPath, transform));
                        }
                    }
                    default -> {
                    }
                }
            } else if (event == XMLStreamConstants.END_ELEMENT) {
                String tag = reader.getLocalName();
                switch (tag) {
                    case "basematerials", "colorgroup" -> {
                        if (currentMaterialId != null && currentColors != null) {
                            materials.put(currentMaterialId, currentColors);
                        }
                        currentMaterialId = null;
                        currentColors = null;
                    }
                    case "mesh" -> inMesh = false;
                    case "object" -> {
                        if (currentObjectId != null) {
                            objects.put(currentObjectId, new ModelObject(
                                    currentObjectId,
                                    currentObjectPid,
                                    currentObjectPindex,
                                    currentVertices,
                                    currentTriangles,
                                    currentComponents
                            ));
                        }
                        currentObjectId = null;
                        currentObjectPid = null;
                        currentObjectPindex = -1;
                        currentVertices = null;
                        currentTriangles = null;
                        currentComponents = null;
                    }
                    default -> {
                    }
                }
            }
        }

        return new ParsedModel(materials, objects, buildItems);
    }

    private static void collectObjectTriangles(
            ZipFile zipFile,
            XMLInputFactory xmlFactory,
            Map<String, ParsedModel> modelCache,
            String modelPath,
            String objectId,
            Transform3D worldTransform,
            List<Triangle> outTriangles,
            Set<String> activeStack,
            int depth
    ) throws IOException, XMLStreamException {
        if (depth > MAX_COMPONENT_DEPTH) {
            throw new IOException("Exceeded maximum 3MF component nesting depth (" + MAX_COMPONENT_DEPTH + ")");
        }

        String normalizedPath = normalizeZipPath(modelPath);
        String visitKey = normalizedPath + "#" + objectId;
        if (!activeStack.add(visitKey)) {
            throw new IOException("Cyclic 3MF component reference detected: " + visitKey);
        }

        try {
            ParsedModel model = loadModel(zipFile, xmlFactory, normalizedPath, modelCache);
            ModelObject obj = model.objects().get(objectId);
            if (obj == null) {
                throw new IOException("Referenced 3MF object id '" + objectId + "' not found in " + normalizedPath);
            }

            if (obj.vertices() != null && obj.rawTriangles() != null) {
                emitMeshTriangles(obj, model.materials(), worldTransform, outTriangles);
            }

            if (obj.components() != null) {
                for (ComponentRef comp : obj.components()) {
                    String nextPath = resolveTargetPath(normalizedPath, comp.externalPath());
                    Transform3D combined = comp.transform().then(worldTransform);
                    collectObjectTriangles(
                            zipFile, xmlFactory, modelCache,
                            nextPath, comp.objectId(), combined,
                            outTriangles, activeStack, depth + 1
                    );
                }
            }
        } finally {
            activeStack.remove(visitKey);
        }
    }

    private static void emitMeshTriangles(
            ModelObject obj,
            Map<String, List<Color>> materials,
            Transform3D worldTransform,
            List<Triangle> outTriangles
    ) throws IOException {
        List<Vector3> rawVerts = obj.vertices();
        List<Vector3> transformedVerts = new ArrayList<>(rawVerts.size());
        for (Vector3 v : rawVerts) {
            transformedVerts.add(worldTransform.apply(v));
        }

        int vertCount = transformedVerts.size();
        for (RawTriangle rt : obj.rawTriangles()) {
            if (rt.v1() < 0 || rt.v1() >= vertCount
                    || rt.v2() < 0 || rt.v2() >= vertCount
                    || rt.v3() < 0 || rt.v3() >= vertCount) {
                throw new IOException("Triangle vertex index out of bounds in 3MF object " + obj.id());
            }

            Color color = resolveTriangleColor(obj, rt, materials);
            outTriangles.add(new Triangle(
                    transformedVerts.get(rt.v1()),
                    transformedVerts.get(rt.v2()),
                    transformedVerts.get(rt.v3()),
                    color
            ));
        }
    }

    private static Color resolveTriangleColor(
            ModelObject obj,
            RawTriangle rt,
            Map<String, List<Color>> materials
    ) {
        String pid = rt.pid() != null ? rt.pid() : obj.defaultPid();
        if (pid == null) {
            return null;
        }
        int pIndex = rt.p1() >= 0 ? rt.p1() : obj.defaultPindex();
        if (pIndex < 0) {
            return null;
        }
        List<Color> palette = materials.get(pid);
        if (palette == null || pIndex >= palette.size()) {
            return null;
        }
        return palette.get(pIndex);
    }

    private static String getAttr(XMLStreamReader reader, String localName) {
        String val = reader.getAttributeValue(null, localName);
        if (val != null) {
            return val;
        }
        for (int i = 0; i < reader.getAttributeCount(); i++) {
            if (localName.equals(reader.getAttributeLocalName(i))) {
                return reader.getAttributeValue(i);
            }
        }
        return null;
    }

    private static String getPathAttr(XMLStreamReader reader) {
        String val = reader.getAttributeValue(PROD_NS, "path");
        if (val != null) {
            return val;
        }
        for (int i = 0; i < reader.getAttributeCount(); i++) {
            if ("path".equals(reader.getAttributeLocalName(i))) {
                return reader.getAttributeValue(i);
            }
        }
        return null;
    }

    private static String resolveTargetPath(String currentModelPath, String externalPath) {
        if (externalPath == null || externalPath.isBlank()) {
            return normalizeZipPath(currentModelPath);
        }
        String cleaned = externalPath.replace('\\', '/').trim();
        if (cleaned.startsWith("/")) {
            return normalizeZipPath(cleaned);
        }
        int lastSlash = currentModelPath.lastIndexOf('/');
        String dir = lastSlash >= 0 ? currentModelPath.substring(0, lastSlash + 1) : "";
        return normalizeZipPath(dir + cleaned);
    }

    private static String normalizeZipPath(String path) {
        String cleaned = path.replace('\\', '/').trim();
        while (cleaned.startsWith("/")) {
            cleaned = cleaned.substring(1);
        }
        return cleaned;
    }

    private static ZipEntry findZipEntry(ZipFile zipFile, String normalizedPath) {
        ZipEntry exact = zipFile.getEntry(normalizedPath);
        if (exact != null) {
            return exact;
        }
        Enumeration<? extends ZipEntry> entries = zipFile.entries();
        while (entries.hasMoreElements()) {
            ZipEntry entry = entries.nextElement();
            if (normalizeZipPath(entry.getName()).equalsIgnoreCase(normalizedPath)) {
                return entry;
            }
        }
        return null;
    }

    private static double parseUnitScale(String unit) {
        if (unit == null) {
            return 1.0;
        }
        return switch (unit.trim().toLowerCase(Locale.ROOT)) {
            case "micron" -> 0.001;
            case "centimeter" -> 10.0;
            case "inch" -> 25.4;
            case "foot" -> 304.8;
            case "meter" -> 1000.0;
            default -> 1.0;
        };
    }

    private static Color parseHexColor(String hex) {
        if (hex == null) {
            return null;
        }
        String trimmed = hex.trim();
        if (!trimmed.startsWith("#")) {
            return null;
        }
        String digits = trimmed.substring(1);
        if (digits.length() == 6 || digits.length() == 8) {
            try {
                int r = Integer.parseInt(digits.substring(0, 2), 16);
                int g = Integer.parseInt(digits.substring(2, 4), 16);
                int b = Integer.parseInt(digits.substring(4, 6), 16);
                return new Color(r, g, b);
            } catch (NumberFormatException ignored) {
                return null;
            }
        }
        return null;
    }

    private static double parseRequiredDouble(String val, String field) throws IOException {
        if (val == null) {
            throw new IOException("Missing required attribute: " + field);
        }
        try {
            return Double.parseDouble(val.trim());
        } catch (NumberFormatException e) {
            throw new IOException("Invalid number for " + field + ": " + val, e);
        }
    }

    private static int parseRequiredInt(String val, String field) throws IOException {
        if (val == null) {
            throw new IOException("Missing required attribute: " + field);
        }
        try {
            return Integer.parseInt(val.trim());
        } catch (NumberFormatException e) {
            throw new IOException("Invalid integer for " + field + ": " + val, e);
        }
    }

    private static int parseOptionalInt(String val, int fallback) {
        if (val == null || val.isBlank()) {
            return fallback;
        }
        try {
            return Integer.parseInt(val.trim());
        } catch (NumberFormatException e) {
            return fallback;
        }
    }

    private record RawTriangle(int v1, int v2, int v3, String pid, int p1) {
    }

    private record ComponentRef(String objectId, String externalPath, Transform3D transform) {
    }

    private record BuildItem(String objectId, String externalPath, Transform3D transform) {
    }

    private record ModelObject(
            String id,
            String defaultPid,
            int defaultPindex,
            List<Vector3> vertices,
            List<RawTriangle> rawTriangles,
            List<ComponentRef> components
    ) {
    }

    private record ParsedModel(
            Map<String, List<Color>> materials,
            Map<String, ModelObject> objects,
            List<BuildItem> buildItems
    ) {
    }

    /**
     * 3MF 3D affine transform matrix using row-vector convention: [x y z 1] * M.
     */
    private record Transform3D(
            double m00, double m01, double m02,
            double m10, double m11, double m12,
            double m20, double m21, double m22,
            double m30, double m31, double m32
    ) {
        static final Transform3D IDENTITY = new Transform3D(
                1, 0, 0,
                0, 1, 0,
                0, 0, 1,
                0, 0, 0
        );

        static Transform3D parse(String raw, double translationScale) throws IOException {
            if (raw == null || raw.isBlank()) {
                return IDENTITY;
            }
            String[] parts = WHITESPACE_PATTERN.split(raw.trim());
            if (parts.length != 12) {
                throw new IOException("Invalid 3MF transform matrix (expected 12 values): " + raw);
            }
            try {
                return new Transform3D(
                        Double.parseDouble(parts[0]), Double.parseDouble(parts[1]), Double.parseDouble(parts[2]),
                        Double.parseDouble(parts[3]), Double.parseDouble(parts[4]), Double.parseDouble(parts[5]),
                        Double.parseDouble(parts[6]), Double.parseDouble(parts[7]), Double.parseDouble(parts[8]),
                        Double.parseDouble(parts[9]) * translationScale,
                        Double.parseDouble(parts[10]) * translationScale,
                        Double.parseDouble(parts[11]) * translationScale
                );
            } catch (NumberFormatException e) {
                throw new IOException("Failed to parse 3MF transform matrix: " + raw, e);
            }
        }

        /**
         * Composes {@code this} transform followed by {@code outer}: (v * this) * outer.
         */
        Transform3D then(Transform3D outer) {
            return new Transform3D(
                    m00 * outer.m00 + m01 * outer.m10 + m02 * outer.m20,
                    m00 * outer.m01 + m01 * outer.m11 + m02 * outer.m21,
                    m00 * outer.m02 + m01 * outer.m12 + m02 * outer.m22,

                    m10 * outer.m00 + m11 * outer.m10 + m12 * outer.m20,
                    m10 * outer.m01 + m11 * outer.m11 + m12 * outer.m21,
                    m10 * outer.m02 + m11 * outer.m12 + m12 * outer.m22,

                    m20 * outer.m00 + m21 * outer.m10 + m22 * outer.m20,
                    m20 * outer.m01 + m21 * outer.m11 + m22 * outer.m21,
                    m20 * outer.m02 + m21 * outer.m12 + m22 * outer.m22,

                    m30 * outer.m00 + m31 * outer.m10 + m32 * outer.m20 + outer.m30,
                    m30 * outer.m01 + m31 * outer.m11 + m32 * outer.m21 + outer.m31,
                    m30 * outer.m02 + m31 * outer.m12 + m32 * outer.m22 + outer.m32
            );
        }

        Vector3 apply(Vector3 v) {
            return new Vector3(
                    v.x() * m00 + v.y() * m10 + v.z() * m20 + m30,
                    v.x() * m01 + v.y() * m11 + v.z() * m21 + m31,
                    v.x() * m02 + v.y() * m12 + v.z() * m22 + m32
            );
        }
    }
}
