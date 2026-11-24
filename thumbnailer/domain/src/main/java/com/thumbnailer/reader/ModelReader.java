package com.thumbnailer.reader;

import com.thumbnailer.model.MeshModel;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Path;
import java.util.Locale;

/**
 * Unified format dispatcher for reading supported 3D model files (.stl and .3mf).
 */
public class ModelReader {

    public static boolean isSupportedFile(Path path) {
        if (path == null || path.getFileName() == null) {
            return false;
        }
        String name = path.getFileName().toString().toLowerCase(Locale.ROOT);
        return name.endsWith(".stl") || name.endsWith(".3mf");
    }

    public static MeshModel read(File file) throws IOException {
        if (!file.exists()) {
            throw new IOException("File does not exist: " + file.getAbsolutePath());
        }

        String name = file.getName().toLowerCase(Locale.ROOT);
        if (name.endsWith(".3mf")) {
            return ThreeMfReader.read(file);
        }
        if (name.endsWith(".stl")) {
            return StlReader.read(file);
        }

        if (hasZipSignature(file)) {
            return ThreeMfReader.read(file);
        }

        return StlReader.read(file);
    }

    private static boolean hasZipSignature(File file) throws IOException {
        if (file.length() < 4) {
            return false;
        }
        byte[] sig = new byte[4];
        try (FileInputStream fis = new FileInputStream(file)) {
            if (fis.read(sig) < 4) {
                return false;
            }
        }
        return sig[0] == 0x50 && sig[1] == 0x4B && sig[2] == 0x03 && sig[3] == 0x04;
    }
}
