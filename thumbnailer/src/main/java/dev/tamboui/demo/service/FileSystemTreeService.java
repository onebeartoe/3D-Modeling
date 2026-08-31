/*
 * Copyright TamboUI Contributors
 * SPDX-License-Identifier: MIT
 */
package dev.tamboui.demo.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import dev.tamboui.demo.FileInfo;
import dev.tamboui.widgets.tree.TreeNode;

/**
 * Service for building and lazily loading filesystem tree data.
 */
public class FileSystemTreeService {

    /**
     * Builds the tree root nodes for the specified directory.
     * Includes a ".." parent node at the top.
     *
     * @param dir the directory path
     * @return the list of root tree nodes
     */
    public List<TreeNode<FileInfo>> buildTreeData(Path dir) {
        List<TreeNode<FileInfo>> rootNodes = new ArrayList<>();

        // Add ".." parent node to the top of the tree
        Path parent = dir.getParent();
        Path parentTarget = (parent != null) ? parent : dir;
        FileInfo parentInfo = FileInfo.dir("..", parentTarget);
        rootNodes.add(TreeNode.of("..", parentInfo).leaf());

        // Add directory child nodes
        rootNodes.addAll(loadDirectoryChildren(dir));

        return rootNodes;
    }

    /**
     * Loads the children of a directory path dynamically.
     *
     * @param dir the directory to inspect
     * @return list of tree nodes for the directory contents
     */
    public List<TreeNode<FileInfo>> loadDirectoryChildren(Path dir) {
        List<TreeNode<FileInfo>> children = new ArrayList<>();
        try (Stream<Path> stream = Files.list(dir)) {
            List<Path> paths = stream.collect(Collectors.toList());
            paths.sort(Comparator
                    .comparing((Path p) -> !Files.isDirectory(p))
                    .thenComparing(p -> {
                        Path fn = p.getFileName();
                        return fn != null ? fn.toString().toLowerCase(Locale.ROOT) : "";
                    }));

            for (Path p : paths) {
                FileInfo info = FileInfo.fromPath(p);
                if (info.type() == FileInfo.FileType.DIRECTORY) {
                    TreeNode<FileInfo> dirNode = TreeNode.of(info.name(), info)
                            .childrenLoader(() -> loadDirectoryChildren(p));
                    children.add(dirNode);
                } else {
                    children.add(TreeNode.of(info.name(), info).leaf());
                }
            }
        } catch (IOException | SecurityException ignored) {
            ignored.printStackTrace();
        }
        return children;
    }
}
