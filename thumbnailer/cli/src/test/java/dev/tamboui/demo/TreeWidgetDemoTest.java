/*
 * Copyright TamboUI Contributors
 * SPDX-License-Identifier: MIT
 */
package dev.tamboui.demo;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

import dev.tamboui.demo.service.FileSystemTreeService;
import dev.tamboui.demo.service.ModelFileScanner;
import dev.tamboui.widgets.tree.TreeNode;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

class TreeWidgetDemoTest {

    @Test
    void testDetermineFileType() {
        assertEquals(FileInfo.FileType.JAVA, FileInfo.determineFileType("Main.java"));
        assertEquals(FileInfo.FileType.KOTLIN, FileInfo.determineFileType("Helper.kt"));
        assertEquals(FileInfo.FileType.GRADLE, FileInfo.determineFileType("build.gradle.kts"));
        assertEquals(FileInfo.FileType.GRADLE, FileInfo.determineFileType("gradlew"));
        assertEquals(FileInfo.FileType.XML, FileInfo.determineFileType("pom.xml"));
        assertEquals(FileInfo.FileType.YAML, FileInfo.determineFileType("config.yml"));
        assertEquals(FileInfo.FileType.JSON, FileInfo.determineFileType("package.json"));
        assertEquals(FileInfo.FileType.MARKDOWN, FileInfo.determineFileType("README.md"));
        assertEquals(FileInfo.FileType.TEXT, FileInfo.determineFileType("notes.txt"));
        assertEquals(FileInfo.FileType.BINARY, FileInfo.determineFileType("app.jar"));
    }

    @Test
    void testParentNodeAtTopOfTheTree(@TempDir Path tempDir) throws IOException {
        Path subDir = tempDir.resolve("child-dir");
        Files.createDirectory(subDir);
        Files.createFile(subDir.resolve("test.txt"));

        TreeWidgetDemo demo = new TreeWidgetDemo(subDir);
        List<TreeNode<FileInfo>> roots = demo.getRoots();

        assertFalse(roots.isEmpty(), "Roots should not be empty");
        TreeNode<FileInfo> parentNode = roots.get(0);
        assertEquals("..", parentNode.label(), "First node should be '..' parent node");
        assertNotNull(parentNode.data(), "Parent node should have FileInfo");
        assertEquals("..", parentNode.data().name());
        assertEquals(FileInfo.FileType.DIRECTORY, parentNode.data().type());
        assertEquals(tempDir, parentNode.data().path());
    }

    @Test
    void testDirectoryContentsSortingAndLazyLoading(@TempDir Path tempDir) throws IOException {
        Path subDir = tempDir.resolve("sub");
        Files.createDirectory(subDir);
        Files.createFile(tempDir.resolve("b_file.txt"));
        Files.createFile(tempDir.resolve("a_file.txt"));
        Files.createFile(subDir.resolve("nested.java"));

        TreeWidgetDemo demo = new TreeWidgetDemo(tempDir);
        List<TreeNode<FileInfo>> roots = demo.getRoots();

        // Roots should contain: ".." + "sub" (directory first) + "a_file.txt" + "b_file.txt"
        assertEquals(4, roots.size());
        assertEquals("..", roots.get(0).label());
        assertEquals("sub", roots.get(1).label());
        assertEquals(FileInfo.FileType.DIRECTORY, roots.get(1).data().type());
        assertEquals("a_file.txt", roots.get(2).label());
        assertEquals("b_file.txt", roots.get(3).label());

        // Test lazy loading of directory children
        TreeNode<FileInfo> subNode = roots.get(1);
        List<TreeNode<FileInfo>> subChildren = subNode.children();
        assertEquals(1, subChildren.size());
        assertEquals("nested.java", subChildren.get(0).label());
        assertEquals(FileInfo.FileType.JAVA, subChildren.get(0).data().type());
    }

    @Test
    void testNavigateToUpdatesCurrentPathAndRoots(@TempDir Path tempDir) throws IOException {
        Path folderA = tempDir.resolve("folderA");
        Path folderB = tempDir.resolve("folderB");
        Files.createDirectory(folderA);
        Files.createDirectory(folderB);
        Files.createFile(folderA.resolve("fileA.txt"));
        Files.createFile(folderB.resolve("fileB.txt"));

        TreeWidgetDemo demo = new TreeWidgetDemo(folderA);
        assertEquals(folderA, demo.getCurrentPath());
        assertEquals(2, demo.getRoots().size()); // ".." + "fileA.txt"
        assertEquals("..", demo.getRoots().get(0).label());
        assertEquals("fileA.txt", demo.getRoots().get(1).label());

        // Navigate to folderB
        demo.navigateTo(folderB);
        assertEquals(folderB, demo.getCurrentPath());
        assertEquals(2, demo.getRoots().size()); // ".." + "fileB.txt"
        assertEquals("..", demo.getRoots().get(0).label());
        assertEquals("fileB.txt", demo.getRoots().get(1).label());
        assertEquals(0, demo.getTreeState().selected());

        // Navigate to parent via ".." node path
        Path parentPath = demo.getRoots().get(0).data().path();
        demo.navigateTo(parentPath);
        assertEquals(tempDir, demo.getCurrentPath());
        // In tempDir we have ".." + "folderA" + "folderB"
        assertEquals(3, demo.getRoots().size());
        assertEquals("..", demo.getRoots().get(0).label());
        assertEquals("folderA", demo.getRoots().get(1).label());
        assertEquals("folderB", demo.getRoots().get(2).label());
    }

    @Test
    void testFileInfoFormattedSizeAndIcons() {
        FileInfo dirInfo = FileInfo.dir("mydir", Path.of("/test/mydir"));
        assertEquals("", dirInfo.formattedSize());
        assertEquals("\uD83D\uDCC1", dirInfo.icon());

        FileInfo smallFile = FileInfo.file("small.txt", FileInfo.FileType.TEXT, 500, Path.of("/test/small.txt"));
        assertEquals("500 B", smallFile.formattedSize());

        FileInfo kbFile = FileInfo.file("kb.txt", FileInfo.FileType.TEXT, 2048, Path.of("/test/kb.txt"));
        assertEquals("2.0 KB", kbFile.formattedSize());

        FileInfo mbFile = FileInfo.file("mb.bin", FileInfo.FileType.BINARY, 2 * 1024 * 1024, Path.of("/test/mb.bin"));
        assertEquals("2.0 MB", mbFile.formattedSize());
    }

    @Test
    void testModelFilesTrackingOnInitialization(@TempDir Path tempDir) throws IOException {
        Files.createFile(tempDir.resolve("model1.stl"));
        Files.createFile(tempDir.resolve("model2.3mf"));
        Files.createFile(tempDir.resolve("notes.txt"));
        Path subDir = tempDir.resolve("ignored_dir.stl");
        Files.createDirectory(subDir);

        TreeWidgetDemo demo = new TreeWidgetDemo(tempDir);
        List<File> modelFiles = demo.getModelFiles();

        assertEquals(2, modelFiles.size());
        assertEquals("model1.stl", modelFiles.get(0).getName());
        assertEquals("model2.3mf", modelFiles.get(1).getName());
    }

    @Test
    void testModelFilesTrackingOnNavigateTo(@TempDir Path tempDir) throws IOException {
        Path folderA = tempDir.resolve("folderA");
        Path folderB = tempDir.resolve("folderB");
        Files.createDirectory(folderA);
        Files.createDirectory(folderB);
        Files.createFile(folderA.resolve("partA.stl"));
        Files.createFile(folderB.resolve("partB1.3mf"));
        Files.createFile(folderB.resolve("partB2.STL"));

        TreeWidgetDemo demo = new TreeWidgetDemo(folderA);
        assertEquals(1, demo.getModelFiles().size());
        assertEquals("partA.stl", demo.getModelFiles().get(0).getName());

        demo.navigateTo(folderB);
        assertEquals(2, demo.getModelFiles().size());
        assertEquals("partB1.3mf", demo.getModelFiles().get(0).getName());
        assertEquals("partB2.STL", demo.getModelFiles().get(1).getName());
    }

    @Test
    void testWaveTextStateInitializationAndAdvance(@TempDir Path tempDir) {
        TreeWidgetDemo demo = new TreeWidgetDemo(tempDir);
        assertNotNull(demo.getWaveTextState(), "WaveTextState should be initialized");
        assertEquals(0, demo.getWaveTextState().tick(), "Initial tick should be 0");

        demo.getWaveTextState().advance();
        assertEquals(1, demo.getWaveTextState().tick(), "Tick should be 1 after advance()");

        demo.getWaveTextState().advance(5);
        assertEquals(6, demo.getWaveTextState().tick(), "Tick should be 6 after advance(5)");
    }

    @Test
    void testFileSystemTreeServiceDirectly(@TempDir Path tempDir) throws IOException {
        FileSystemTreeService service = new FileSystemTreeService();
        Files.createDirectory(tempDir.resolve("dirA"));
        Files.createFile(tempDir.resolve("fileA.txt"));

        List<TreeNode<FileInfo>> roots = service.buildTreeData(tempDir);
        assertEquals(3, roots.size());
        assertEquals("..", roots.get(0).label());
        assertEquals("dirA", roots.get(1).label());
        assertEquals("fileA.txt", roots.get(2).label());
    }

    @Test
    void testModelFileScannerDirectly(@TempDir Path tempDir) throws IOException {
        ModelFileScanner scanner = new ModelFileScanner();
        Files.createFile(tempDir.resolve("alpha.3mf"));
        Files.createFile(tempDir.resolve("beta.stl"));
        Files.createFile(tempDir.resolve("gamma.txt"));

        List<File> files = scanner.scanModelFiles(tempDir);
        assertEquals(2, files.size());
        assertEquals("alpha.3mf", files.get(0).getName());
        assertEquals("beta.stl", files.get(1).getName());
    }
}
