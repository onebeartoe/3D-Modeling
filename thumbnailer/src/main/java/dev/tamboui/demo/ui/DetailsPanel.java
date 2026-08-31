/*
 * Copyright TamboUI Contributors
 * SPDX-License-Identifier: MIT
 */
package dev.tamboui.demo.ui;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import dev.tamboui.demo.FileInfo;
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
import dev.tamboui.widgets.wavetext.WaveText;
import dev.tamboui.widgets.wavetext.WaveTextState;

/**
 * UI panel for rendering details of the selected item and discovered 3D model files.
 */
public class DetailsPanel {

    /**
     * Renders the details panel containing selection details and model file status.
     *
     * @param frame               the frame to render to
     * @param area                the target rectangle area
     * @param info                the selected file info (or null)
     * @param modelFiles          the list of model files in the current folder
     * @param modelFilesTextState the wave text state for model files header
     */
    public void render(
            Frame frame,
            Rect area,
            FileInfo info,
            List<File> modelFiles,
            WaveTextState modelFilesTextState) 
    {
        Text content;

        if (info != null) 
        {
            List<Line> lines = new ArrayList<>();
            lines.add(Line.from(Span.raw("Name:   ").bold(), Span.raw(info.name())));
            lines.add(Line.from(Span.raw("Path:   ").bold(), Span.raw(info.path() != null ? info.path().toString() : "").dim()));
            lines.add(Line.from(Span.raw("Type:   ").bold(), Span.raw(info.type().name()).dim()));
            lines.add(Line.from(Span.raw("Size:   ").bold(), Span.raw(info.formattedSize()).dim()));
            lines.add(Line.from(Span.raw("Status: ").bold(), formatStatus(info.status())));
            lines.add(Line.empty());
            lines.add(Line.from(Span.raw("Icon:   ").bold(), Span.raw(info.icon())));

            content = Text.from(lines);
        } 
        else 
        {
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

        List<Rect> rows = Layout.vertical()
                .constraints(
                        Constraint.percentage(50),
                        Constraint.percentage(50)
                )
                .split(area);

        frame.renderWidget(details, rows.get(0));

        WaveText waveText = WaveText.builder()
                .text("Modeling Thumbnailer")
                .color(Color.LIGHT_YELLOW)
                .peakCount(3)
                .build();

        
        // Model Files
        List<Line> modelFilesLines = new ArrayList<>();        
        if (modelFiles != null && !modelFiles.isEmpty()) 
        {
            for (File modelFile : modelFiles) 
            {
                modelFilesLines.add(Line.from(Span.raw(modelFile.getName())));
            }
        }
        Text modelFilesText = Text.from(modelFilesLines);
        Paragraph modelFilesWidget = Paragraph.builder()
                .text(modelFilesText)
                .block(Block.builder()
                        .borders(Borders.ALL)
                        .borderType(BorderType.ROUNDED)
                        .borderStyle(Style.EMPTY.fg(Color.DARK_GRAY))
                        .build())
                .build();

        frame.renderWidget(modelFilesWidget, rows.get(1));
        frame.renderStatefulWidget(waveText, rows.get(1), modelFilesTextState);
    }

    /**
     * Formats the file status as a styled Span.
     *
     * @param status the status
     * @return the styled Span
     */
    public Span formatStatus(FileInfo.FileStatus status) {
        return switch (status) {
            case MODIFIED -> Span.raw("Modified").yellow();
            case NEW -> Span.raw("New").green();
            case IGNORED -> Span.raw("Ignored").dim();
            case NORMAL -> Span.raw("Normal").dim();
        };
    }
}
