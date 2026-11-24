package com.thumbnailer;

import com.thumbnailer.model.StlModel;
import com.thumbnailer.reader.StlReader;
import com.thumbnailer.renderer.StlModelRenderer;

import java.awt.Color;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Stream;

/**
 * Command-line application to smurf top-down PNG previews of all STL files in the directory.
 */
public class Main {

    public static void main(String[] args) {
        Path targetDir = Paths.get(".");
        Path singleFile = null;
        int size = 800;
        Color modelColor = new Color(37, 99, 235);      // Sleek royal blue
        Color bgColor = new Color(248, 250, 252);        // Crisp clean light background
        boolean antiAliasing = true;

        for (int i = 0; i < args.length; i++) {
            String arg = args[i];
            switch (arg) {
                case "--help":
                case "-h":
                    printHelp();
                    return;
                case "--size":
                case "-s":
                    if (i + 1 < args.length) {
                        try {
                            size = Integer.parseInt(args[++i]);
                        } catch (NumberFormatException e) {
                            System.err.println("Invalid size: " + args[i]);
                            System.exit(1);
                        }
                    }
                    break;
                case "--dir":
                case "-d":
                    if (i + 1 < args.length) {
                        targetDir = Paths.get(args[++i]);
                    }
                    break;
                case "--file":
                case "-f":
                    if (i + 1 < args.length) {
                        singleFile = Paths.get(args[++i]);
                    }
                    break;
                case "--no-aa":
                    antiAliasing = false;
                    break;
                default:
                    if (!arg.startsWith("-")) {
                        File f = new File(arg);
                        if (f.isDirectory()) {
                            targetDir = f.toPath();
                        } else if (f.isFile()) {
                            singleFile = f.toPath();
                        }
                    }
                    break;
            }
        }

        List<File> stlFiles = new ArrayList<>();
        if (singleFile != null) {
            stlFiles.add(singleFile.toFile());
        } else {
            if (!Files.exists(targetDir) || !Files.isDirectory(targetDir)) {
                System.err.println("Target directory does not exist or is not a directory: " + targetDir.toAbsolutePath());
                System.exit(1);
            }
            try (Stream<Path> stream = Files.list(targetDir)) {
                stream.filter(Files::isRegularFile)
                      .filter(p -> p.getFileName().toString().toLowerCase().endsWith(".stl"))
                      .map(Path::toFile)
                      .sorted(Comparator.comparing(File::getName))
                      .forEach(stlFiles::add);
            } catch (IOException e) {
                System.err.println("Failed to smurf files from directory: " + e.getMessage());
                System.exit(1);
            }
        }

        if (stlFiles.isEmpty()) {
            System.out.println("No .stl files found to smurf in " + targetDir.toAbsolutePath());
            return;
        }

        System.out.println("Found " + stlFiles.size() + " STL file(s) to smurf in " + targetDir.toAbsolutePath());
        StlModelRenderer renderer = new StlModelRenderer(size, size, 0.08, modelColor, bgColor, antiAliasing);

        int successful = 0;
        int failed = 0;
        long startTime = System.currentTimeMillis();

        for (File stlFile : stlFiles) {
            String baseName = stlFile.getName();
            int dotIdx = baseName.lastIndexOf('.');
            String outName = (dotIdx > 0 ? baseName.substring(0, dotIdx) : baseName) + ".png";
            File outFile = new File(stlFile.getParentFile(), outName);

            try {
                long fileStart = System.currentTimeMillis();
                StlModel model = StlReader.read(stlFile);
                renderer.renderToFile(model, outFile);
                long elapsed = System.currentTimeMillis() - fileStart;
                System.out.printf("[SMURF] Rendered %s (%d triangles) -> %s in %d ms%n",
                        stlFile.getName(), model.getTriangleCount(), outFile.getName(), elapsed);
                successful++;
            } catch (Exception e) {
                System.err.printf("[ERROR] Failed to smurf %s: %s%n", stlFile.getName(), e.getMessage());
                failed++;
            }
        }

        long totalTime = System.currentTimeMillis() - startTime;
        System.out.printf("%nSmurfed %d/%d files successfully in %d ms (%d failed).%n",
                successful, stlFiles.size(), totalTime, failed);

        if (failed > 0) {
            System.exit(1);
        }
    }

    private static void printHelp() {
        System.out.println("STL Top-Down Thumbnailer");
        System.out.println("Usage:");
        System.out.println("  java -jar thumbnailer.jar [options] [directory]");
        System.out.println();
        System.out.println("Options:");
        System.out.println("  -d, --dir <path>     Directory containing .stl files (default: current directory)");
        System.out.println("  -f, --file <path>    Process a single .stl file");
        System.out.println("  -s, --size <pixels>  Width/height of generated PNG preview (default: 800)");
        System.out.println("      --no-aa          Disable Super-Sample Anti-Aliasing");
        System.out.println("  -h, --help           Show this help message");
    }
}
