package com.thumbnailer;

import com.thumbnailer.model.StlModel;
import com.thumbnailer.model.Triangle;
import com.thumbnailer.model.Vector3;
import com.thumbnailer.reader.StlReader;
import com.thumbnailer.renderer.StlModelRenderer;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.file.Path;

import static org.junit.jupiter.api.Assertions.*;

public class StlReaderTest {

    @Test
    public void testReadAsciiStl(@TempDir Path tempDir) throws IOException {
        File asciiFile = tempDir.resolve("test_ascii.stl").toFile();
        try (FileWriter writer = new FileWriter(asciiFile)) {
            writer.write("solid test\n");
            writer.write("  facet normal 0.0 0.0 1.0\n");
            writer.write("    outer loop\n");
            writer.write("      vertex 0.0 0.0 0.0\n");
            writer.write("      vertex 10.0 0.0 0.0\n");
            writer.write("      vertex 0.0 10.0 0.0\n");
            writer.write("    endloop\n");
            writer.write("  endfacet\n");
            writer.write("endsolid test\n");
        }

        StlModel model = StlReader.read(asciiFile);
        assertNotNull(model);
        assertEquals(1, model.getTriangleCount());
        assertEquals(0.0, model.getBounds().minX(), 1e-5);
        assertEquals(10.0, model.getBounds().maxX(), 1e-5);
        assertEquals(0.0, model.getBounds().minY(), 1e-5);
        assertEquals(10.0, model.getBounds().maxY(), 1e-5);
    }

    @Test
    public void testReadBinaryStl(@TempDir Path tempDir) throws IOException {
        File binaryFile = tempDir.resolve("test_binary.stl").toFile();
        try (FileOutputStream fos = new FileOutputStream(binaryFile)) {
            byte[] header = new byte[80];
            fos.write(header);

            ByteBuffer countBuf = ByteBuffer.allocate(4).order(ByteOrder.LITTLE_ENDIAN);
            countBuf.putInt(1);
            fos.write(countBuf.array());

            ByteBuffer triBuf = ByteBuffer.allocate(50).order(ByteOrder.LITTLE_ENDIAN);
            // Normal
            triBuf.putFloat(0.0f); triBuf.putFloat(0.0f); triBuf.putFloat(1.0f);
            // V1
            triBuf.putFloat(0.0f); triBuf.putFloat(0.0f); triBuf.putFloat(5.0f);
            // V2
            triBuf.putFloat(20.0f); triBuf.putFloat(0.0f); triBuf.putFloat(5.0f);
            // V3
            triBuf.putFloat(0.0f); triBuf.putFloat(15.0f); triBuf.putFloat(5.0f);
            // Attribute
            triBuf.putShort((short) 0);

            fos.write(triBuf.array());
        }

        StlModel model = StlReader.read(binaryFile);
        assertNotNull(model);
        assertEquals(1, model.getTriangleCount());
        assertEquals(0.0, model.getBounds().minX(), 1e-5);
        assertEquals(20.0, model.getBounds().maxX(), 1e-5);
        assertEquals(0.0, model.getBounds().minY(), 1e-5);
        assertEquals(15.0, model.getBounds().maxY(), 1e-5);
        assertEquals(5.0, model.getBounds().minZ(), 1e-5);
        assertEquals(5.0, model.getBounds().maxZ(), 1e-5);
    }

    @Test
    public void testRenderToFile(@TempDir Path tempDir) throws IOException {
        File asciiFile = tempDir.resolve("render_test.stl").toFile();
        try (FileWriter writer = new FileWriter(asciiFile)) {
            writer.write("solid test\n");
            writer.write("  facet normal 0.0 0.0 1.0\n");
            writer.write("    outer loop\n");
            writer.write("      vertex -10.0 -10.0 0.0\n");
            writer.write("      vertex 10.0 -10.0 0.0\n");
            writer.write("      vertex 0.0 10.0 0.0\n");
            writer.write("    endloop\n");
            writer.write("  endfacet\n");
            writer.write("endsolid test\n");
        }

        StlModel model = StlReader.read(asciiFile);
        StlModelRenderer renderer = new StlModelRenderer(200, 200, 0.1, Color.BLUE, Color.WHITE, false);
        BufferedImage img = renderer.render(model);

        assertNotNull(img);
        assertEquals(200, img.getWidth());
        assertEquals(200, img.getHeight());

        // Center pixel should be rendered (not background color)
        int centerColor = img.getRGB(100, 100);
        assertNotEquals(Color.WHITE.getRGB(), centerColor);

        // Corner pixel should be background color
        int cornerColor = img.getRGB(5, 5);
        assertEquals(Color.WHITE.getRGB(), cornerColor);

        File pngFile = tempDir.resolve("out.png").toFile();
        renderer.renderToFile(model, pngFile);
        assertTrue(pngFile.exists());
        assertTrue(pngFile.length() > 0);
    }
}
