///usr/bin/env jbang "$0" "$@" ; exit $?
//DEPS dev.tamboui:tamboui-widgets:LATEST
//DEPS dev.tamboui:tamboui-jline3-backend:LATEST

/*
 * Copyright TamboUI Contributors
 * SPDX-License-Identifier: MIT
 */
package dev.tamboui.demo;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import dev.tamboui.layout.Constraint;
import dev.tamboui.layout.Layout;
import dev.tamboui.layout.Rect;
import dev.tamboui.style.Color;
import dev.tamboui.style.Style;
import dev.tamboui.terminal.Backend;
import dev.tamboui.terminal.BackendFactory;
import dev.tamboui.terminal.Frame;
import dev.tamboui.terminal.Terminal;
import dev.tamboui.text.Line;
import dev.tamboui.text.Span;
import dev.tamboui.text.Text;
import dev.tamboui.widgets.block.Block;
import dev.tamboui.widgets.block.BorderType;
import dev.tamboui.widgets.block.Borders;
import dev.tamboui.widgets.block.Title;
import dev.tamboui.widgets.common.SizedWidget;
import dev.tamboui.widgets.paragraph.Paragraph;
import dev.tamboui.widgets.tree.GuideStyle;
import dev.tamboui.widgets.tree.TreeNode;
import dev.tamboui.widgets.tree.TreeState;
import dev.tamboui.widgets.tree.TreeWidget;

/**
 * Demo TUI application showcasing the TreeWidget with dynamic local filesystem navigation.
 * <p>
 * Demonstrates TreeWidget features using only the widget API (no toolkit):
 * <ul>
 *   <li>Dynamic filesystem navigation with expand/collapse and Enter to change directory</li>
 *   <li>Parent directory ("..") node at the top of the tree</li>
 *   <li>Custom node rendering with SizedWidget</li>
 *   <li>Guide styles (Unicode, ASCII, None)</li>
 *   <li>Highlight styles and symbols</li>
 *   <li>Scrollbar support</li>
 * </ul>
 */
public class TreeWidgetDemo 
{

    private void currentDirectory() 
    {
        var path = currentPath.toFile();
       
        System.out.println("Current Directory Not supported yet.");
    }

    private void recursiveDirectory() 
    {
        System.out.println("Recursive Directory Not supported yet.");
    }

    // ════════════════════════════════════════════════════════════════
    // Data Model
    // ════════════════════════════════════════════════════════════════

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

    // ════════════════════════════════════════════════════════════════
    // Application State
    // ════════════════════════════════════════════════════════════════

    private boolean running = true;
    private final TreeState treeState = new TreeState();
    private Path currentPath;
    private List<TreeNode<FileInfo>> roots;
    private List<TreeWidget.FlatEntry<TreeNode<FileInfo>>> lastFlatEntries;
    private GuideStyle currentGuideStyle = GuideStyle.UNICODE;

    /**
     * Constructs a TreeWidgetDemo starting at the current working directory.
     */
    public TreeWidgetDemo() {
        this(Paths.get(".").toAbsolutePath().normalize());
    }

    /**
     * Constructs a TreeWidgetDemo starting at the specified path.
     *
     * @param startPath the initial directory path
     */
    public TreeWidgetDemo(Path startPath) {
        this.currentPath = startPath.toAbsolutePath().normalize();
        this.roots = buildTreeData(this.currentPath);
    }

    /**
     * Demo entry point.
     *
     * @param args the CLI arguments
     * @throws Exception on unexpected error
     */
    public static void main(String[] args) throws Exception {
        Path startPath = args.length > 0
                ? Paths.get(args[0]).toAbsolutePath().normalize()
                : Paths.get(".").toAbsolutePath().normalize();
        new TreeWidgetDemo(startPath).run();
    }

    /**
     * Runs the demo application.
     *
     * @throws Exception if an error occurs during execution
     */
    public void run() throws Exception {
        try (Backend backend = BackendFactory.create()) {
            backend.enableRawMode();
            backend.enterAlternateScreen();
            backend.hideCursor();

            Terminal<Backend> terminal = new Terminal<>(backend);

            backend.onResize(() -> terminal.draw(this::ui));

            while (running) {
                terminal.draw(this::ui);

                int c = backend.read(100);
                if (c == -2 || c == -1) {
                    continue;
                }

                handleInput(c, backend);
            }
        }
    }

    private void handleInput(int c, Backend backend) throws IOException {
        if (c == 27) {
            int next = backend.peek(50);
            if (next == '[') {
                backend.read(50);
                int code = backend.read(50);
                handleEscapeSequence(code);
            }
            return;
        }

        switch (c) {
            case 'q', 'Q', 3 -> running = false;
            case 'c', 'C' -> currentDirectory();
            case 'j', 'J' -> selectNext();
            case 'k', 'K' -> treeState.selectPrevious();
            case 'l', 'L' -> expandSelected();
            case 'h', 'H' -> collapseSelected();
            case 'r', 'R' -> recursiveDirectory();
            case ' ' -> toggleSelected();
            case '\r', '\n' -> enterSelected();
            case 'g' -> treeState.selectFirst();
            case 'G' -> selectLast();
            case '1' -> currentGuideStyle = GuideStyle.UNICODE;
            case '2' -> currentGuideStyle = GuideStyle.ASCII;
            case '3' -> currentGuideStyle = GuideStyle.NONE;
        }
    }

    private void handleEscapeSequence(int code) {
        switch (code) {
            case 'A' -> treeState.selectPrevious(); // Up
            case 'B' -> selectNext(); // Down
            case 'C' -> expandSelected(); // Right
            case 'D' -> collapseSelected(); // Left
        }
    }

    private void selectNext() {
        if (lastFlatEntries != null && !lastFlatEntries.isEmpty()) {
            treeState.selectNext(lastFlatEntries.size() - 1);
        }
    }

    private void selectLast() {
        if (lastFlatEntries != null && !lastFlatEntries.isEmpty()) {
            treeState.selectLast(lastFlatEntries.size() - 1);
        }
    }

    private void expandSelected() {
        if (lastFlatEntries == null || lastFlatEntries.isEmpty()) {
            return;
        }
        int idx = Math.min(treeState.selected(), lastFlatEntries.size() - 1);
        TreeNode<FileInfo> node = lastFlatEntries.get(idx).node();
        if (!node.isLeaf()) {
            if (node.isExpanded()) {
                if (!node.children().isEmpty() && idx + 1 < lastFlatEntries.size()) {
                    treeState.select(idx + 1);
                }
            } else {
                node.expanded(true);
            }
        }
    }

    private void collapseSelected() {
        if (lastFlatEntries == null || lastFlatEntries.isEmpty()) {
            return;
        }
        int idx = Math.min(treeState.selected(), lastFlatEntries.size() - 1);
        TreeWidget.FlatEntry<TreeNode<FileInfo>> entry = lastFlatEntries.get(idx);
        TreeNode<FileInfo> node = entry.node();
        if (node.isExpanded() && !node.isLeaf()) {
            node.expanded(false);
        } else {
            TreeNode<FileInfo> parent = entry.parent();
            if (parent != null) {
                for (int i = 0; i < lastFlatEntries.size(); i++) {
                    if (lastFlatEntries.get(i).node() == parent) {
                        treeState.select(i);
                        break;
                    }
                }
            }
        }
    }

    private void toggleSelected() {
        if (lastFlatEntries == null || lastFlatEntries.isEmpty()) {
            return;
        }
        int idx = Math.min(treeState.selected(), lastFlatEntries.size() - 1);
        TreeNode<FileInfo> node = lastFlatEntries.get(idx).node();
        if (!node.isLeaf()) {
            node.toggleExpanded();
        }
    }

    /**
     * Handles Enter key press: navigates to the selected directory if a directory node is selected.
     */
    private void enterSelected() {
        if (lastFlatEntries == null || lastFlatEntries.isEmpty()) {
            return;
        }
        int idx = Math.min(treeState.selected(), lastFlatEntries.size() - 1);
        TreeNode<FileInfo> node = lastFlatEntries.get(idx).node();
        FileInfo info = node.data();
        if (info != null && info.type() == FileInfo.FileType.DIRECTORY && info.path() != null) {
            navigateTo(info.path());
        }
    }

    /**
     * Changes path to the specified directory and reloads tree child nodes.
     *
     * @param dir the target directory
     */
    public void navigateTo(Path dir) {
        try {
            Path target = dir.toAbsolutePath().normalize();
            if (Files.isDirectory(target)) {
                this.currentPath = target;
                this.roots = buildTreeData(this.currentPath);
                this.treeState.select(0);
                this.treeState.offset(0);
            }
        } catch (SecurityException ignored) {
        }
    }

    // ════════════════════════════════════════════════════════════════
    // Tree Data Construction
    // ════════════════════════════════════════════════════════════════

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
        }
        return children;
    }

    // ════════════════════════════════════════════════════════════════
    // UI Rendering
    // ════════════════════════════════════════════════════════════════

    private void ui(Frame frame) {
        Rect area = frame.area();

        List<Rect> layout = Layout.vertical()
                .constraints(
                        Constraint.length(3),  // Header
                        Constraint.fill(),     // Main content
                        Constraint.length(3)   // Footer
                )
                .split(area);

        renderHeader(frame, layout.get(0));
        renderMainContent(frame, layout.get(1));
        renderFooter(frame, layout.get(2));
    }

    private void renderHeader(Frame frame, Rect area) {
        Block headerBlock = Block.builder()
                .borders(Borders.ALL)
                .borderType(BorderType.ROUNDED)
                .borderStyle(Style.EMPTY.fg(Color.CYAN))
                .title(Title.from(
                        Line.from(
                                Span.raw(" TamboUI ").bold().cyan(),
                                Span.raw("TreeWidget Demo ").yellow()
                        )
                ).centered())
                .build();
        
        
        Line helpLine = Line.from(
                                Span.raw(" [C]Current Current Directory ").dim(),
                Span.raw(" [R] Recursive Directory ").dim(),
                Span.raw(" Guide: ").dim(),
                Span.raw("Some Guide").bold().cyan(),
                Span.raw("   "),
                Span.raw("1/2/3").bold().yellow(),
                Span.raw(" Style  ").dim(),
                Span.raw("\u2191\u2193/jk").bold().yellow(),
                Span.raw(" Navigate  ").dim(),
                Span.raw("\u2190\u2192/hl").bold().yellow(),
                Span.raw(" Collapse/Expand  ").dim(),
                Span.raw("Space").bold().yellow(),
                Span.raw(" Toggle  ").dim(),
                Span.raw("Enter").bold().yellow(),
                Span.raw(" Change Dir  ").dim(),
                Span.raw("q").bold().yellow(),
                Span.raw(" Quit").dim()
        );

        Paragraph footer = Paragraph.builder()
                .text(Text.from(helpLine))
                .block(Block.builder()
                        .borders(Borders.ALL)
                        .borderType(BorderType.ROUNDED)
                        .borderStyle(Style.EMPTY.fg(Color.DARK_GRAY))
                        
.title(Title.from(
                        Line.from(
                                Span.raw(" TamboUI ").bold().cyan(),
                                Span.raw("TreeWidget Demo ").yellow()
                        )
                ))                        
                        
                        .build())
                .centered()
                .build();        
        
        
        

        frame.renderWidget(footer, area);
//        frame.renderWidget(headerBlock, area);
    }

    private void renderMainContent(Frame frame, Rect area) {
        List<Rect> cols = Layout.horizontal()
                .constraints(
                        Constraint.percentage(65),
                        Constraint.percentage(35)
                )
                .spacing(1)
                .split(area);

        renderTree(frame, cols.get(0));
        renderDetails(frame, cols.get(1));
    }

    private void renderTree(Frame frame, Rect area) {
        String titleText = " " + currentPath.toString() + " ";
        TreeWidget<TreeNode<FileInfo>> treeWidget = TreeWidget.<TreeNode<FileInfo>>builder()
                .roots(roots)
                .children(TreeNode::children)
                .isLeaf(TreeNode::isLeaf)
                .expansionState(TreeNode::isExpanded, TreeNode::expanded)
                .nodeRenderer(this::renderNode)
                .guideStyle(currentGuideStyle)
                .highlightStyle(Style.EMPTY.reversed())
                .highlightSymbol("\u25B6 ") // ▶
                .scrollbar()
                .scrollbarThumbStyle(Style.EMPTY.fg(Color.CYAN))
                .block(Block.builder()
                        .borders(Borders.ALL)
                        .borderType(BorderType.ROUNDED)
                        .borderStyle(Style.EMPTY.fg(Color.WHITE))
                        .title(Title.from(titleText))
                        .build())
                .build();

        frame.renderStatefulWidget(treeWidget, area, treeState);
        this.lastFlatEntries = treeWidget.lastFlatEntries();
    }

    /**
     * Renders a tree node using SizedWidget with right-aligned metadata.
     */
    private SizedWidget renderNode(TreeNode<FileInfo> node) {
        FileInfo info = node.data();
        if (info == null) {
            return SizedWidget.of(Paragraph.from(node.label()));
        }

        // Create a custom widget that renders left content and right-aligned metadata
        return SizedWidget.of((rect, buffer) -> {
            if (rect.isEmpty()) {
                return;
            }

            // Build left content: icon + name
            Line leftLine = buildLeftContent(info);

            // Build right content: size + badge
            Line rightLine = buildRightContent(info);

            int leftWidth = leftLine.width();
            int rightWidth = rightLine.width();
            int availableWidth = rect.width();

            // Render left content
            buffer.setLine(rect.left(), rect.top(), leftLine);

            // Render right content at right edge (if there's room)
            if (rightWidth > 0 && leftWidth + rightWidth + 1 < availableWidth) {
                int rightX = rect.right() - rightWidth;
                buffer.setLine(rightX, rect.top(), rightLine);
            }
        });
    }

    private Line buildLeftContent(FileInfo info) {
        Span icon = Span.raw(info.icon() + " ");
        Span name = Span.raw(info.name());
        Color statusColor = info.statusColor();
        if (statusColor != null) {
            name = name.fg(statusColor);
        }

        if (info.type() == FileInfo.FileType.DIRECTORY) {
            return Line.from(icon, name.bold());
        }

        return Line.from(icon, name);
    }

    private Line buildRightContent(FileInfo info) {
        if (info.type() == FileInfo.FileType.DIRECTORY) {
            return Line.empty();
        }

        String size = info.formattedSize();
        if (size.isEmpty()) {
            return Line.empty();
        }

        Span sizeSpan = Span.raw(size).dim();

        if (info.status() == FileInfo.FileStatus.MODIFIED) {
            Span badge = Span.raw(" M").bg(Color.YELLOW).fg(Color.BLACK);
            return Line.from(sizeSpan, badge);
        } else if (info.status() == FileInfo.FileStatus.NEW) {
            Span badge = Span.raw(" +").bg(Color.GREEN).fg(Color.BLACK);
            return Line.from(sizeSpan, badge);
        }

        return Line.from(sizeSpan);
    }

    private void renderDetails(Frame frame, Rect area) {
        FileInfo info = getSelectedInfo();

        Text content;
        if (info != null) {
            content = Text.from(
                    Line.from(Span.raw("Name:   ").bold(), Span.raw(info.name())),
                    Line.from(Span.raw("Path:   ").bold(), Span.raw(info.path() != null ? info.path().toString() : "").dim()),
                    Line.from(Span.raw("Type:   ").bold(), Span.raw(info.type().name()).dim()),
                    Line.from(Span.raw("Size:   ").bold(), Span.raw(info.formattedSize()).dim()),
                    Line.from(Span.raw("Status: ").bold(), formatStatus(info.status())),
                    Line.empty(),
                    Line.from(Span.raw("Icon:   ").bold(), Span.raw(info.icon()))
            );
        } else {
            content = Text.from(Line.from(Span.raw("(no selection)").dim()));
        }

        Paragraph details = Paragraph.builder()
                .text(content)
                .block(Block.builder()
                        .borders(Borders.ALL)
                        .borderType(BorderType.ROUNDED)
                        .borderStyle(Style.EMPTY.fg(Color.DARK_GRAY))
                        .title(Title.from(" Details "))
                        .build())
                .build();

        frame.renderWidget(details, area);
    }

    private FileInfo getSelectedInfo() {
        if (lastFlatEntries == null || lastFlatEntries.isEmpty()) {
            return null;
        }
        int idx = Math.min(treeState.selected(), lastFlatEntries.size() - 1);
        TreeNode<FileInfo> node = lastFlatEntries.get(idx).node();
        return node.data();
    }

    private Span formatStatus(FileInfo.FileStatus status) {
        return switch (status) {
            case MODIFIED -> Span.raw("Modified").yellow();
            case NEW -> Span.raw("New").green();
            case IGNORED -> Span.raw("Ignored").dim();
            case NORMAL -> Span.raw("Normal").dim();
        };
    }

    private void renderFooter(Frame frame, Rect area) {
        String guideStyleName = switch (currentGuideStyle) {
            case UNICODE -> "Unicode";
            case ASCII -> "ASCII";
            case NONE -> "None";
        };

        Line helpLine = Line.from(
                Span.raw(" Guide: ").dim(),
                Span.raw(guideStyleName).bold().cyan(),
                Span.raw("   "),
                Span.raw("1/2/3").bold().yellow(),
                Span.raw(" Style  ").dim(),
                Span.raw("\u2191\u2193/jk").bold().yellow(),
                Span.raw(" Navigate  ").dim(),
                Span.raw("\u2190\u2192/hl").bold().yellow(),
                Span.raw(" Collapse/Expand  ").dim(),
                Span.raw("Space").bold().yellow(),
                Span.raw(" Toggle  ").dim(),
                Span.raw("Enter").bold().yellow(),
                Span.raw(" Change Dir  ").dim(),
                Span.raw("q").bold().yellow(),
                Span.raw(" Quit").dim()
        );

        Paragraph footer = Paragraph.builder()
                .text(Text.from(helpLine))
                .block(Block.builder()
                        .borders(Borders.ALL)
                        .borderType(BorderType.ROUNDED)
                        .borderStyle(Style.EMPTY.fg(Color.DARK_GRAY))
                        .build())
                .build();

        frame.renderWidget(footer, area);
    }

    /**
     * Gets the current path.
     *
     * @return the current path
     */
    public Path getCurrentPath() {
        return currentPath;
    }

    /**
     * Gets the current root nodes.
     *
     * @return the root nodes
     */
    public List<TreeNode<FileInfo>> getRoots() {
        return Collections.unmodifiableList(roots);
    }

    /**
     * Gets the tree state.
     *
     * @return the tree state
     */
    public TreeState getTreeState() {
        return treeState;
    }
}
