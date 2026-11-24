package com.thumbnailer;

import com.thumbnailer.model.MeshModel;
import com.thumbnailer.reader.ModelReader;
import com.thumbnailer.reader.ThreeMfReader;
import com.thumbnailer.renderer.TopDownModelRenderer;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import static org.junit.jupiter.api.Assertions.*;

public class ThreeMfReaderTest {

    private static final String RELS_XML = """
            <?xml version="1.0" encoding="UTF-8"?>
            <Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
              <Relationship Target="/3D/3dmodel.model" Id="rel-1"
                Type="http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel"/>
            </Relationships>
            """;

    @Test
    public void testReadBasic3mfAndRender(@TempDir Path tempDir) throws IOException {
        String modelXml = """
                <?xml version="1.0" encoding="UTF-8"?>
                <model unit="millimeter" xmlns="http://schemas.microsoft.com/3dmanufacturing/core/2015/02">
                  <resources>
                    <object id="1" type="model">
                      <mesh>
                        <vertices>
                          <vertex x="-10" y="-10" z="0"/>
                          <vertex x="10" y="-10" z="0"/>
                          <vertex x="0" y="10" z="0"/>
                        </vertices>
                        <triangles>
                          <triangle v1="0" v2="1" v3="2"/>
                        </triangles>
                      </mesh>
                    </object>
                  </resources>
                  <build>
                    <item objectid="1"/>
                  </build>
                </model>
                """;

        File file = write3mf(tempDir.resolve("basic.3mf"), Map.of(
                "_rels/.rels", RELS_XML,
                "3D/3dmodel.model", modelXml
        ));

        MeshModel model = ModelReader.read(file);
        assertNotNull(model);
        assertEquals(1, model.getTriangleCount());
        assertEquals(-10.0, model.getBounds().minX(), 1e-5);
        assertEquals(10.0, model.getBounds().maxX(), 1e-5);
        assertEquals(-10.0, model.getBounds().minY(), 1e-5);
        assertEquals(10.0, model.getBounds().maxY(), 1e-5);

        TopDownModelRenderer renderer = new TopDownModelRenderer(200, 200, 0.1, Color.BLUE, Color.WHITE, false);
        BufferedImage img = renderer.render(model);
        assertNotEquals(Color.WHITE.getRGB(), img.getRGB(100, 100));
        assertEquals(Color.WHITE.getRGB(), img.getRGB(5, 5));

        File pngFile = tempDir.resolve("basic.png").toFile();
        renderer.renderToFile(model, pngFile);
        assertTrue(pngFile.exists());
        assertTrue(pngFile.length() > 0);
    }

    @Test
    public void testReadComponentsTransformsProductionPathAndColor(@TempDir Path tempDir) throws IOException {
        String subModelXml = """
                <?xml version="1.0" encoding="UTF-8"?>
                <model unit="millimeter"
                       xmlns="http://schemas.microsoft.com/3dmanufacturing/core/2015/02"
                       xmlns:m="http://schemas.microsoft.com/3dmanufacturing/material/2015/02">
                  <resources>
                    <m:colorgroup id="10">
                      <m:color color="#FF0000FF"/>
                    </m:colorgroup>
                    <object id="2" type="model" pid="10" pindex="0">
                      <mesh>
                        <vertices>
                          <vertex x="0" y="0" z="0"/>
                          <vertex x="4" y="0" z="0"/>
                          <vertex x="0" y="4" z="0"/>
                        </vertices>
                        <triangles>
                          <triangle v1="0" v2="1" v3="2"/>
                        </triangles>
                      </mesh>
                    </object>
                  </resources>
                </model>
                """;

        String rootModelXml = """
                <?xml version="1.0" encoding="UTF-8"?>
                <model unit="millimeter"
                       xmlns="http://schemas.microsoft.com/3dmanufacturing/core/2015/02"
                       xmlns:p="http://schemas.microsoft.com/3dmanufacturing/production/2015/06">
                  <resources>
                    <object id="1" type="model">
                      <components>
                        <component objectid="2" p:path="/3D/Objects/sub.model" transform="2 0 0 0 2 0 0 0 1 10 20 5"/>
                      </components>
                    </object>
                  </resources>
                  <build>
                    <item objectid="1" transform="1 0 0 0 1 0 0 0 1 100 0 0"/>
                  </build>
                </model>
                """;

        File file = write3mf(tempDir.resolve("assembly.3mf"), Map.of(
                "_rels/.rels", RELS_XML,
                "3D/3dmodel.model", rootModelXml,
                "3D/Objects/sub.model", subModelXml
        ));

        MeshModel model = ThreeMfReader.read(file);
        assertEquals(1, model.getTriangleCount());
        // Local [0..4] scaled by 2 => [0..8], translated by (10,20,5) + item (100,0,0) => X:[110..118], Y:[20..28], Z:5
        assertEquals(110.0, model.getBounds().minX(), 1e-5);
        assertEquals(118.0, model.getBounds().maxX(), 1e-5);
        assertEquals(20.0, model.getBounds().minY(), 1e-5);
        assertEquals(28.0, model.getBounds().maxY(), 1e-5);
        assertEquals(5.0, model.getBounds().minZ(), 1e-5);
        assertEquals(Color.RED, model.getTriangles().get(0).color());
    }

    @Test
    public void testBaseMaterialsUnitsInstancingAndCycleDetection(@TempDir Path tempDir) throws IOException {
        String instancedModelXml = """
                <?xml version="1.0" encoding="UTF-8"?>
                <model unit="centimeter" xmlns="http://schemas.microsoft.com/3dmanufacturing/core/2015/02">
                  <resources>
                    <basematerials id="5">
                      <base name="Green" displaycolor="#00FF00"/>
                    </basematerials>
                    <object id="1" type="model">
                      <mesh>
                        <vertices>
                          <vertex x="0" y="0" z="0"/>
                          <vertex x="1" y="0" z="0"/>
                          <vertex x="0" y="1" z="0"/>
                        </vertices>
                        <triangles>
                          <triangle v1="0" v2="1" v3="2" pid="5" p1="0"/>
                        </triangles>
                      </mesh>
                    </object>
                  </resources>
                  <build>
                    <item objectid="1"/>
                    <item objectid="1" transform="1 0 0 0 1 0 0 0 1 2 0 0"/>
                  </build>
                </model>
                """;

        File file = write3mf(tempDir.resolve("instanced.3mf"), Map.of(
                "_rels/.rels", RELS_XML,
                "3D/3dmodel.model", instancedModelXml
        ));

        MeshModel model = ThreeMfReader.read(file);
        assertEquals(2, model.getTriangleCount());
        // 1 cm = 10 mm; second item shifts X by +2 cm (+20 mm), spanning [0..30]
        assertEquals(0.0, model.getBounds().minX(), 1e-5);
        assertEquals(30.0, model.getBounds().maxX(), 1e-5);
        assertEquals(10.0, model.getBounds().maxY(), 1e-5);
        assertEquals(Color.GREEN, model.getTriangles().get(0).color());

        String cyclicXml = """
                <?xml version="1.0" encoding="UTF-8"?>
                <model unit="millimeter" xmlns="http://schemas.microsoft.com/3dmanufacturing/core/2015/02">
                  <resources>
                    <object id="1" type="model">
                      <components>
                        <component objectid="1"/>
                      </components>
                    </object>
                  </resources>
                  <build>
                    <item objectid="1"/>
                  </build>
                </model>
                """;
        File cyclicFile = write3mf(tempDir.resolve("cyclic.3mf"), Map.of(
                "_rels/.rels", RELS_XML,
                "3D/3dmodel.model", cyclicXml
        ));
        assertThrows(IOException.class, () -> ThreeMfReader.read(cyclicFile));
    }

    @Test
    public void testSupportsFileFilter() {
        assertTrue(ModelReader.isSupportedFile(Path.of("model.stl")));
        assertTrue(ModelReader.isSupportedFile(Path.of("MODEL.3MF")));
        assertFalse(ModelReader.isSupportedFile(Path.of("notes.txt")));
    }

    private static File write3mf(Path target, Map<String, String> entries) throws IOException {
        File file = target.toFile();
        try (ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(file))) {
            for (Map.Entry<String, String> entry : entries.entrySet()) {
                zos.putNextEntry(new ZipEntry(entry.getKey()));
                zos.write(entry.getValue().getBytes(StandardCharsets.UTF_8));
                zos.closeEntry();
            }
        }
        return file;
    }
}
