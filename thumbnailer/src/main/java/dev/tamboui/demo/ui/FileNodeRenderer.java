
package dev.tamboui.demo.ui;

import dev.tamboui.demo.FileInfo;
import dev.tamboui.style.Color;
import dev.tamboui.text.Line;
import dev.tamboui.text.Span;
import dev.tamboui.widgets.common.SizedWidget;
import dev.tamboui.widgets.paragraph.Paragraph;
import dev.tamboui.widgets.tree.TreeNode;

/**
 * Renderer for custom tree nodes displaying file icons, names, sizes, and status badges.
 */
public class FileNodeRenderer {

    /**
     * Renders a tree node using SizedWidget with right-aligned metadata.
     *
     * @param node the tree node
     * @return the sized widget
     */
    public SizedWidget renderNode(TreeNode<FileInfo> node) {
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

    /**
     * Builds the left part of a node (icon and filename with status color).
     *
     * @param info the file info
     * @return the Line
     */
    public Line buildLeftContent(FileInfo info) {
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

    /**
     * Builds the right part of a node (file size and status badge).
     *
     * @param info the file info
     * @return the Line
     */
    public Line buildRightContent(FileInfo info) {
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
}
