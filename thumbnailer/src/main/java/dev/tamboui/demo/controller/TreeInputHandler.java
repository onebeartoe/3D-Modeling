
package dev.tamboui.demo.controller;

import java.io.IOException;

import dev.tamboui.terminal.Backend;
import dev.tamboui.widgets.tree.GuideStyle;

/**
 * Handles terminal key events and dispatches actions to the navigation controller.
 */
public class TreeInputHandler 
{
    private final TreeNavigationController navigationController;
    private final Runnable quitAction;
    private GuideStyle guideStyle = GuideStyle.UNICODE;
    
    public TreeInputHandler(TreeNavigationController navigationController, Runnable quitAction) {
        this.navigationController = navigationController;
        this.quitAction = quitAction;
    }

    /**
     * Handles an input character from the backend.
     *
     * @param c       the character code read
     * @param backend the terminal backend
     * @throws IOException on I/O error
     */
    public void handleInput(int c, Backend backend) throws IOException {
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
            case 'q', 'Q', 3 -> quitAction.run();
            case 'c', 'C' -> navigationController.currentDirectory();
            case 'j', 'J' -> navigationController.selectNext();
            case 'k', 'K' -> navigationController.selectPrevious();
            case 'l', 'L' -> navigationController.expandSelected();
            case 'h', 'H' -> navigationController.collapseSelected();
            case 'r', 'R' -> navigationController.recursiveDirectory();
            case ' ' -> navigationController.toggleSelected();
            case '\r', '\n' -> navigationController.enterSelected();
            case 'g' -> navigationController.selectFirst();
            case 'G' -> navigationController.selectLast();
            case '1' -> guideStyle = GuideStyle.UNICODE;
            case '2' -> guideStyle = GuideStyle.ASCII;
            case '3' -> guideStyle = GuideStyle.NONE;
        }
    }

    /**
     * Handles ANSI escape sequence code (e.g. arrow keys).
     *
     * @param code the escape sequence character code
     */
    public void handleEscapeSequence(int code) {
        switch (code) {
            case 'A' -> navigationController.selectPrevious(); // Up
            case 'B' -> navigationController.selectNext();     // Down
            case 'C' -> navigationController.expandSelected(); // Right
            case 'D' -> navigationController.collapseSelected(); // Left
        }
    }

    public GuideStyle getGuideStyle() {
        return guideStyle;
    }

    public void setGuideStyle(GuideStyle guideStyle) {
        this.guideStyle = guideStyle;
    }
}
