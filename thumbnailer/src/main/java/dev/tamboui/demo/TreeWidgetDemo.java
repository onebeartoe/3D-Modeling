///usr/bin/env jbang "$0" "$@" ; exit $?
//DEPS dev.tamboui:tamboui-widgets:LATEST
//DEPS dev.tamboui:tamboui-jline3-backend:LATEST

package dev.tamboui.demo;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import dev.tamboui.demo.controller.TreeInputHandler;
import dev.tamboui.demo.controller.TreeNavigationController;
import dev.tamboui.demo.service.FileSystemTreeService;
import dev.tamboui.demo.service.ModelFileScanner;
import dev.tamboui.demo.ui.DetailsPanel;
import dev.tamboui.demo.ui.FileNodeRenderer;
import dev.tamboui.demo.ui.TreeDemoView;
import dev.tamboui.terminal.Backend;
import dev.tamboui.terminal.BackendFactory;
import dev.tamboui.terminal.Terminal;
import dev.tamboui.widgets.tree.TreeNode;
import dev.tamboui.widgets.tree.TreeState;
import dev.tamboui.widgets.wavetext.WaveTextState;
import java.io.PrintStream;

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
public class TreeWidgetDemo {

    private boolean running = true;

    private final WaveTextState waveTextState = new WaveTextState();
    private final WaveTextState modelFilesTextState = new WaveTextState();

    private final FileSystemTreeService fileSystemService;
    private final ModelFileScanner modelFileScanner;
    private final TreeNavigationController navigationController;
    private final TreeInputHandler inputHandler;
    private final FileNodeRenderer nodeRenderer;
    private final DetailsPanel detailsPanel;
    private final TreeDemoView view;

    /**
     * Constructs a TreeWidgetDemo starting at the current working directory.
     */
    public TreeWidgetDemo() 
    {
        this(Paths.get(".").toAbsolutePath().normalize());
    }

    /**
     * Constructs a TreeWidgetDemo starting at the specified path.
     *
     * @param startPath the initial directory path
     */
    public TreeWidgetDemo(Path startPath) 
    {
        this.fileSystemService = new FileSystemTreeService();
        this.modelFileScanner = new ModelFileScanner();
        this.navigationController = new TreeNavigationController(startPath, fileSystemService, modelFileScanner);
        this.inputHandler = new TreeInputHandler(navigationController, () -> this.running = false);
        this.nodeRenderer = new FileNodeRenderer();
        this.detailsPanel = new DetailsPanel();
        this.view = new TreeDemoView(
                navigationController,
                inputHandler,
                nodeRenderer,
                detailsPanel,
                waveTextState,
                modelFilesTextState
        );
    }

    /**
     * Demo entry point.
     *
     * @param args the CLI arguments
     * @throws Exception on unexpected error
     */
    public static void main(String[] args) throws Exception 
    {
        File logFile = new File("target/app.log");
        PrintStream logStream = new PrintStream(logFile);
        System.setOut(logStream);
        System.setErr(logStream);
        
        Path startPath = args.length > 0
                ? Paths.get(args[0]).toAbsolutePath().normalize()
                : Paths.get(".").toAbsolutePath().normalize();
        
        var app = new TreeWidgetDemo(startPath);

        app.run();
    }

    /**
     * Runs the demo application.
     *
     * @throws Exception if an error occurs during execution
     */
    public void run() throws Exception 
    {
        try (Backend backend = BackendFactory.create()) 
        {
            backend.enableRawMode();
            backend.enterAlternateScreen();
            backend.hideCursor();
//backend.            

            Terminal<Backend> terminal = new Terminal<>(backend);

            backend.onResize(() -> terminal.draw(view::render));

            while (running) {
                terminal.draw(view::render);

                waveTextState.advance();
                modelFilesTextState.advance();

                int c = backend.read(100);
                if (c == -2 || c == -1) {
                    continue;
                }

                inputHandler.handleInput(c, backend);
            }
        }
    }

    /**
     * Navigates to the specified directory.
     *
     * @param dir the directory path
     */
    public void navigateTo(Path dir) {
        navigationController.navigateTo(dir);
    }

    /**
     * Gets the current path.
     *
     * @return the current path
     */
    public Path getCurrentPath() {
        return navigationController.getCurrentPath();
    }

    /**
     * Gets the current root nodes.
     *
     * @return the root nodes
     */
    public List<TreeNode<FileInfo>> getRoots() {
        return navigationController.getRoots();
    }

    /**
     * Gets the tree state.
     *
     * @return the tree state
     */
    public TreeState getTreeState() {
        return navigationController.getTreeState();
    }

    /**
     * Gets the model files found in the current path.
     *
     * @return the model files
     */
    public List<File> getModelFiles() {
        return navigationController.getModelFiles();
    }

    /**
     * Gets the wave text state.
     *
     * @return the wave text state
     */
    public WaveTextState getWaveTextState() {
        return waveTextState;
    }
}
