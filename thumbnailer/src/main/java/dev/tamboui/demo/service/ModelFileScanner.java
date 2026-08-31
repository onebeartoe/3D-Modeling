/*
 * Copyright TamboUI Contributors
 * SPDX-License-Identifier: MIT
 */
package dev.tamboui.demo.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * Service for scanning and filtering 3D model files in a directory.
 */
public class ModelFileScanner {

    /**
     * Scans the specified directory for supported 3D model files (.stl, .3mf).
     *
     * @param directory the directory to scan
     * @return sorted list of model files
     */
    public List<File> scanModelFiles(Path directory) {
        List<File> files = new ArrayList<>();
        if (directory == null || !Files.isDirectory(directory)) {
            return files;
        }

        try (Stream<Path> stream = Files.list(directory)) {
            List<Path> paths = stream.collect(Collectors.toList());
            paths.sort(Comparator.comparing(p -> {
                Path fn = p.getFileName();
                return fn != null ? fn.toString().toLowerCase(Locale.ROOT) : "";
            }));

            for (Path p : paths) {
                if (!Files.isDirectory(p)) {
                    String name = p.getFileName() != null ? p.getFileName().toString() : p.toString();
                    String lower = name.toLowerCase(Locale.ROOT);
                    if (lower.endsWith(".stl") || lower.endsWith(".3mf")) {
                        files.add(p.toFile());
                    }
                }
            }
        } catch (IOException | SecurityException ignored) {
            ignored.printStackTrace();
        }
        return files;
    }
}
