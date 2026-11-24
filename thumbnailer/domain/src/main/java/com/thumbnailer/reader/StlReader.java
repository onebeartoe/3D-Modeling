package com.thumbnailer.reader;

import com.thumbnailer.model.StlModel;
import com.thumbnailer.model.Triangle;
import com.thumbnailer.model.Vector3;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

/**
 * Robust STL file reader supporting both ASCII and Binary STL formats.
 */
public class StlReader {

    private static final Pattern WHITESPACE_PATTERN = Pattern.compile("\\s+");

    public static StlModel read(File file) throws IOException {
        if (!file.exists()) {
            throw new IOException("File does not exist: " + file.getAbsolutePath());
        }

        if (isBinaryStl(file)) {
            try {
                return readBinary(file);
            } catch (Exception e) {
                // Fallback to ASCII in case binary detection was a false positive
                return readAscii(file);
            }
        } else {
            try {
                return readAscii(file);
            } catch (Exception e) {
                // Fallback to binary in case ASCII failed
                return readBinary(file);
            }
        }
    }

    private static boolean isBinaryStl(File file) throws IOException {
        long fileLength = file.length();
        if (fileLength < 84) {
            return false;
        }

        byte[] buffer = new byte[512];
        int bytesRead;
        try (FileInputStream fis = new FileInputStream(file)) {
            bytesRead = fis.read(buffer);
        }
        if (bytesRead < 84) {
            return false;
        }

        ByteBuffer bb = ByteBuffer.wrap(buffer, 80, 4).order(ByteOrder.LITTLE_ENDIAN);
        int triangleCount = bb.getInt();

        // Binary STL file size must be 84 + 50 * triangleCount
        if (triangleCount > 0 && fileLength == 84L + 50L * Integer.toUnsignedLong(triangleCount)) {
            String start = new String(buffer, 0, Math.min(bytesRead, 80), StandardCharsets.US_ASCII);
            if (!start.trim().startsWith("solid") || !containsFacetKeyword(file)) {
                return true;
            }
        }

        // ASCII STL never contains null bytes
        for (int i = 0; i < bytesRead; i++) {
            if (buffer[i] == 0) {
                return true;
            }
        }

        return false;
    }

    private static boolean containsFacetKeyword(File file) {
        byte[] buf = new byte[4096];
        try (FileInputStream fis = new FileInputStream(file)) {
            int read = fis.read(buf);
            if (read > 0) {
                String sample = new String(buf, 0, read, StandardCharsets.US_ASCII);
                return sample.toLowerCase().contains("facet");
            }
        } catch (IOException ignored) {
        }
        return false;
    }

    public static StlModel readAscii(File file) throws IOException {
        List<Triangle> triangles = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(file), StandardCharsets.UTF_8))) {
            String line;
            Vector3 currentNormal = null;
            List<Vector3> currentVertices = new ArrayList<>(3);

            while ((line = reader.readLine()) != null) {
                String trimmed = line.trim();
                if (trimmed.isEmpty()) {
                    continue;
                }

                String lower = trimmed.toLowerCase();
                if (lower.startsWith("facet normal")) {
                    currentNormal = parseVector(trimmed.substring(12).trim());
                    currentVertices.clear();
                } else if (lower.startsWith("vertex")) {
                    Vector3 v = parseVector(trimmed.substring(6).trim());
                    currentVertices.add(v);
                    if (currentVertices.size() == 3) {
                        triangles.add(new Triangle(
                                currentVertices.get(0),
                                currentVertices.get(1),
                                currentVertices.get(2),
                                currentNormal
                        ));
                        currentVertices.clear();
                        currentNormal = null;
                    }
                }
            }
        }

        if (triangles.isEmpty()) {
            throw new IOException("No triangles found in ASCII STL file: " + file.getName());
        }

        return new StlModel(triangles);
    }

    private static Vector3 parseVector(String str) throws IOException {
        String[] tokens = WHITESPACE_PATTERN.split(str.trim());
        if (tokens.length < 3) {
            throw new IOException("Invalid vector format: " + str);
        }
        try {
            double x = Double.parseDouble(tokens[0]);
            double y = Double.parseDouble(tokens[1]);
            double z = Double.parseDouble(tokens[2]);
            return new Vector3(x, y, z);
        } catch (NumberFormatException e) {
            throw new IOException("Failed to parse vector coordinates from: " + str, e);
        }
    }

    public static StlModel readBinary(File file) throws IOException {
        long fileLength = file.length();
        if (fileLength < 84) {
            throw new IOException("File too short for binary STL: " + fileLength + " bytes");
        }

        try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file))) {
            byte[] header = new byte[80];
            int readHeader = bis.read(header);
            if (readHeader < 80) {
                throw new IOException("Incomplete binary STL header");
            }

            byte[] countBuf = new byte[4];
            int readCount = bis.read(countBuf);
            if (readCount < 4) {
                throw new IOException("Incomplete triangle count in binary STL");
            }
            int triangleCount = ByteBuffer.wrap(countBuf).order(ByteOrder.LITTLE_ENDIAN).getInt();
            if (triangleCount < 0) {
                throw new IOException("Invalid negative triangle count: " + triangleCount);
            }

            List<Triangle> triangles = new ArrayList<>(Math.min(triangleCount, 1_000_000));
            byte[] triangleBuf = new byte[50];
            ByteBuffer bb = ByteBuffer.wrap(triangleBuf).order(ByteOrder.LITTLE_ENDIAN);

            for (int i = 0; i < triangleCount; i++) {
                int readBytes = 0;
                while (readBytes < 50) {
                    int r = bis.read(triangleBuf, readBytes, 50 - readBytes);
                    if (r < 0) {
                        break;
                    }
                    readBytes += r;
                }
                if (readBytes < 50) {
                    break; // End of file reached
                }

                bb.rewind();
                float nx = bb.getFloat();
                float ny = bb.getFloat();
                float nz = bb.getFloat();
                float v1x = bb.getFloat();
                float v1y = bb.getFloat();
                float v1z = bb.getFloat();
                float v2x = bb.getFloat();
                float v2y = bb.getFloat();
                float v2z = bb.getFloat();
                float v3x = bb.getFloat();
                float v3y = bb.getFloat();
                float v3z = bb.getFloat();
                // attribute byte count is 2 bytes at the end of the 50 bytes

                Vector3 normal = new Vector3(nx, ny, nz);
                Vector3 v1 = new Vector3(v1x, v1y, v1z);
                Vector3 v2 = new Vector3(v2x, v2y, v2z);
                Vector3 v3 = new Vector3(v3x, v3y, v3z);

                triangles.add(new Triangle(v1, v2, v3, normal));
            }

            return new StlModel(triangles);
        }
    }
}
