
package dev.tamboui.demo;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Locale;

import dev.tamboui.style.Color;

/**
 * Represents a file or directory with metadata.
 *
 * @param name      the display name
 * @param type      the file type
 * @param sizeBytes the size in bytes
 * @param status    the file status
 * @param path      the filesystem path
 */
public record FileInfo(
        String name,
        FileType type,
        long sizeBytes,
        FileStatus status,
        Path path
) {
    /**
     * Supported file types for display icons and categorization.
     */
    public enum FileType {
        /** Directory */
        DIRECTORY,
        /** Java source file */
        JAVA,
        /** Kotlin source file */
        KOTLIN,
        /** XML file */
        XML,
        /** YAML file */
        YAML,
        /** JSON file */
        JSON,
        /** Markdown file */
        MARKDOWN,
        /** Gradle build file */
        GRADLE,
        /** Plain text file */
        TEXT,
        /** Binary or other file */
        BINARY
    }

    /**
     * Status indicator for files.
     */
    public enum FileStatus {
        /** Normal unmodified file */
        NORMAL,
        /** Modified file */
        MODIFIED,
        /** Newly created file */
        NEW,
        /** Ignored or hidden file */
        IGNORED
    }

    /**
     * Creates a directory FileInfo.
     *
     * @param name the directory name
     * @param path the path
     * @return the FileInfo
     */
    public static FileInfo dir(String name, Path path) {
        return new FileInfo(name, FileType.DIRECTORY, 0, FileStatus.NORMAL, path);
    }

    /**
     * Creates a file FileInfo.
     *
     * @param name the file name
     * @param type the file type
     * @param size the size in bytes
     * @param path the path
     * @return the FileInfo
     */
    public static FileInfo file(String name, FileType type, long size, Path path) {
        return new FileInfo(name, type, size, FileStatus.NORMAL, path);
    }

    /**
     * Creates a file FileInfo with status.
     *
     * @param name   the file name
     * @param type   the file type
     * @param size   the size in bytes
     * @param status the status
     * @param path   the path
     * @return the FileInfo
     */
    public static FileInfo file(String name, FileType type, long size, FileStatus status, Path path) {
        return new FileInfo(name, type, size, status, path);
    }

    /**
     * Creates a FileInfo instance by inspecting a filesystem path.
     *
     * @param path the path to inspect
     * @return the FileInfo
     */
    public static FileInfo fromPath(Path path) {
        boolean isDir = Files.isDirectory(path);
        String name = path.getFileName() != null ? path.getFileName().toString() : path.toString();
        FileStatus status = FileStatus.NORMAL;
        try {
            if (Files.isHidden(path)) {
                status = FileStatus.IGNORED;
            }
        } catch (IOException ignored) {
        }

        if (isDir) {
            return new FileInfo(name, FileType.DIRECTORY, 0, status, path);
        }

        FileType type = determineFileType(name);
        long size = 0;
        try {
            size = Files.size(path);
        } catch (IOException ignored) {
        }

        return new FileInfo(name, type, size, status, path);
    }

    /**
     * Determines the file type from the filename.
     *
     * @param fileName the filename
     * @return the FileType
     */
    public static FileType determineFileType(String fileName) {
        String lower = fileName.toLowerCase(Locale.ROOT);
        if (lower.endsWith(".java")) {
            return FileType.JAVA;
        }
        if (lower.endsWith(".kt")) {
            return FileType.KOTLIN;
        }
        if (lower.endsWith(".gradle") || lower.endsWith(".gradle.kts")
                || lower.equals("gradlew") || lower.equals("gradlew.bat")) {
            return FileType.GRADLE;
        }
        if (lower.endsWith(".xml") || lower.endsWith(".pom") || lower.endsWith(".iml")) {
            return FileType.XML;
        }
        if (lower.endsWith(".yml") || lower.endsWith(".yaml")) {
            return FileType.YAML;
        }
        if (lower.endsWith(".json")) {
            return FileType.JSON;
        }
        if (lower.endsWith(".md") || lower.endsWith(".markdown")
                || lower.endsWith(".adoc") || lower.endsWith(".asciidoc")) {
            return FileType.MARKDOWN;
        }
        if (lower.endsWith(".txt") || lower.endsWith(".log") || lower.endsWith(".properties")
                || lower.endsWith(".sh") || lower.endsWith(".bash") || lower.endsWith(".zsh")
                || lower.endsWith(".toml") || lower.endsWith(".conf") || lower.endsWith(".ini")
                || lower.endsWith(".env") || lower.startsWith(".git") || lower.equals("license")
                || lower.equals("readme") || lower.endsWith(".csv") || lower.endsWith(".sql")) {
            return FileType.TEXT;
        }
        if (lower.endsWith(".class") || lower.endsWith(".jar") || lower.endsWith(".war")
                || lower.endsWith(".zip") || lower.endsWith(".tar") || lower.endsWith(".gz")
                || lower.endsWith(".7z") || lower.endsWith(".png") || lower.endsWith(".jpg")
                || lower.endsWith(".jpeg") || lower.endsWith(".gif") || lower.endsWith(".ico")
                || lower.endsWith(".svg") || lower.endsWith(".pdf") || lower.endsWith(".exe")
                || lower.endsWith(".so") || lower.endsWith(".dll") || lower.endsWith(".dylib")
                || lower.endsWith(".bin")) {
            return FileType.BINARY;
        }
        return FileType.TEXT;
    }

    /**
     * Gets the icon string for this file.
     *
     * @return icon string
     */
    public String icon() {
        return switch (type) {
            case DIRECTORY -> "\uD83D\uDCC1"; // 📁
            case JAVA -> "\u2615"; // ☕
            case KOTLIN -> "K";
            case XML -> "\uD83D\uDCCB"; // 📋
            case YAML, JSON -> "\u2699"; // ⚙
            case MARKDOWN -> "\uD83D\uDCDD"; // 📝
            case GRADLE -> "\uD83D\uDC18"; // 🐘
            case TEXT -> "\uD83D\uDCC4"; // 📄
            case BINARY -> "\uD83D\uDCE6"; // 📦
        };
    }

    /**
     * Formats the file size for display.
     *
     * @return formatted size string
     */
    public String formattedSize() {
        if (type == FileType.DIRECTORY) {
            return "";
        }
        if (sizeBytes < 1024) {
            return sizeBytes + " B";
        }
        if (sizeBytes < 1024 * 1024) {
            return String.format(Locale.ROOT, "%.1f KB", sizeBytes / 1024.0);
        }
        return String.format(Locale.ROOT, "%.1f MB", sizeBytes / (1024.0 * 1024));
    }

    /**
     * Gets the status color.
     *
     * @return the color or null
     */
    public Color statusColor() {
        return switch (status) {
            case MODIFIED -> Color.YELLOW;
            case NEW -> Color.GREEN;
            case IGNORED -> Color.DARK_GRAY;
            case NORMAL -> null;
        };
    }
}
