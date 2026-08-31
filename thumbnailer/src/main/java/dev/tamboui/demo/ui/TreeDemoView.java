/*
 * Copyright TamboUI Contributors
 * SPDX-License-Identifier: MIT
 */
package dev.tamboui.demo.ui;

import java.util.List;

import dev.tamboui.demo.FileInfo;
import dev.tamboui.demo.controller.TreeInputHandler;
import dev.tamboui.demo.controller.TreeNavigationController;
import dev.tamboui.layout.Constraint;
import dev.tamboui.layout.Layout;
import dev.tamboui.layout.Rect;
import dev.tamboui.style.Color;
import dev.tamboui.style.Style;
import dev.tamboui.terminal.Frame;
import dev.tamboui.text.Line;
import dev.tamboui.text.Span;
import dev.tamboui.text.Text;
import dev.tamboui.widgets.block.Block;
import dev.tamboui.widgets.block.BorderType;
import dev.tamboui.widgets.block.Borders;
import dev.tamboui.widgets.block.Title;
import dev.tamboui.widgets.paragraph.Paragraph;
import dev.tamboui.widgets.tree.TreeNode;
import dev.tamboui.widgets.tree.TreeWidget;
import dev.tamboui.widgets.wavetext.WaveText;
import dev.tamboui.widgets.wavetext.WaveTextState;

/**
 * Main UI view for layout structuring and rendering the terminal application.
 */
public class TreeDemoView 
{
    private final TreeNavigationController navigationController;
    private final TreeInputHandler inputHandler;
    private final FileNodeRenderer nodeRenderer;
    private final DetailsPanel detailsPanel;
    private final WaveTextState waveTextState;
    private final WaveTextState modelFilesTextState;

    public TreeDemoView(
            TreeNavigationController navigationController,
            TreeInputHandler inputHandler,
            FileNodeRenderer nodeRenderer,
            DetailsPanel detailsPanel,
            WaveTextState waveTextState,
            WaveTextState modelFilesTextState) 
    {
        this.navigationController = navigationController;
        this.inputHandler = inputHandler;
        this.nodeRenderer = nodeRenderer;
        this.detailsPanel = detailsPanel;
        this.waveTextState = waveTextState;
        this.modelFilesTextState = modelFilesTextState;
    }

    /**
     * Renders the complete application layout to the frame.
     *
     * @param frame the frame
     */
    public void render(Frame frame) 
    {
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

    private void renderHeader(Frame frame, Rect area) 
    {
        Line helpLine = Line.from(
                Span.raw(" [C]Current Directory ").dim(),
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

        WaveText waveText = WaveText.builder()
                .text("Modeling Thumbnailer")
                .color(Color.LIGHT_YELLOW)
                .peakCount(3)
                .build();

        Paragraph footer = Paragraph.builder()
                .text(Text.from(helpLine))
                .block(Block.builder()
                        .borders(Borders.ALL)
                        .borderType(BorderType.ROUNDED)
                        .borderStyle(Style.EMPTY.fg(Color.DARK_GRAY))
                        .build())
                .centered()
                .build();

        frame.renderWidget(footer, area);
        frame.renderStatefulWidget(waveText, area, waveTextState);
    }

    private void renderMainContent(Frame frame, Rect area) 
    {
        List<Rect> cols = Layout.horizontal()
                .constraints(
                        Constraint.percentage(65),
                        Constraint.percentage(35)
                )
                .spacing(1)
                .split(area);

        renderTree(frame, cols.get(0));
        
        detailsPanel.render(
                frame,
                cols.get(1),
                navigationController.getSelectedInfo(),
                navigationController.getModelFiles(),
                modelFilesTextState
        );
    }

    private void renderTree(Frame frame, Rect area) 
    {
        String titleText = " " + navigationController.getCurrentPath().toString() + " ";
        
        TreeWidget<TreeNode<FileInfo>> treeWidget = TreeWidget.<TreeNode<FileInfo>>builder()
                .roots(navigationController.getRoots())
                .children(TreeNode::children)
                .isLeaf(TreeNode::isLeaf)
                .expansionState(TreeNode::isExpanded, TreeNode::expanded)
                .nodeRenderer(nodeRenderer::renderNode)
                .guideStyle(inputHandler.getGuideStyle())
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

        frame.renderStatefulWidget(treeWidget, area, navigationController.getTreeState());
        
        navigationController.setLastFlatEntries(treeWidget.lastFlatEntries());
    }

    private void renderFooter(Frame frame, Rect area) 
    {
        String guideStyleName = switch (inputHandler.getGuideStyle()) 
        {
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
}
