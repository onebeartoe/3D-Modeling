
package dev.tamboui.demo.controller;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import dev.tamboui.demo.FileInfo;
import dev.tamboui.demo.service.FileSystemTreeService;
import dev.tamboui.demo.service.ModelFileScanner;
import dev.tamboui.widgets.tree.TreeNode;
import dev.tamboui.widgets.tree.TreeState;
import dev.tamboui.widgets.tree.TreeWidget;
import java.io.IOException;
import java.nio.file.StandardOpenOption;
import org.onebeartoe.modeling.openscad.test.suite.OpenScadCliTestSuite;
import org.onebeartoe.modeling.openscad.test.suite.model.DirectoryProfile;
import org.onebeartoe.modeling.openscad.test.suite.model.RunProfile;
import org.onebeartoe.modeling.openscad.test.suite.utils.PngGenerator;

/**
 * Controller responsible for managing navigation state, selection, and tree data updates.
 */
public class TreeNavigationController 
{
    private final FileSystemTreeService fileSystemService;
    private final ModelFileScanner modelFileScanner;
    private final TreeState treeState = new TreeState();

    private Path currentPath;

    public String status = "Empty Status";    
    
    private List<TreeNode<FileInfo>> roots;
    private List<TreeWidget.FlatEntry<TreeNode<FileInfo>>> lastFlatEntries;
    private List<File> modelFiles = new ArrayList<>();

    /**
     * Creates a new TreeNavigationController.
     *
     * @param startPath         the initial path
     * @param fileSystemService the file system tree service
     * @param modelFileScanner  the model file scanner
     */
    public TreeNavigationController(
            Path startPath,
            FileSystemTreeService fileSystemService,
            ModelFileScanner modelFileScanner)
    {
        this.fileSystemService = fileSystemService;
        this.modelFileScanner = modelFileScanner;
        this.currentPath = startPath.toAbsolutePath().normalize();
        this.roots = fileSystemService.buildTreeData(this.currentPath);
        this.modelFiles = modelFileScanner.scanModelFiles(this.currentPath);
    }

    /**
     * Changes path to the specified directory and reloads tree child nodes.
     *
     * @param dir the target directory
     */
    public void navigateTo(Path dir) 
    {
        try 
        {
            Path target = dir.toAbsolutePath().normalize();
            if (Files.isDirectory(target)) {
                this.currentPath = target;
                this.roots = fileSystemService.buildTreeData(this.currentPath);
                this.treeState.select(0);
                this.treeState.offset(0);
                this.modelFiles = modelFileScanner.scanModelFiles(this.currentPath);
            }
        } 
        catch (SecurityException ignored) 
        {
            ignored.printStackTrace();
        }
    }

    /**
     * Moves selection down to the next node.
     */
    public void selectNext() {
        if (lastFlatEntries != null && !lastFlatEntries.isEmpty()) {
            treeState.selectNext(lastFlatEntries.size() - 1);
        }
    }

    /**
     * Moves selection up to the previous node.
     */
    public void selectPrevious() {
        treeState.selectPrevious();
    }

    /**
     * Moves selection to the first node.
     */
    public void selectFirst() {
        treeState.selectFirst();
    }

    /**
     * Moves selection to the last node.
     */
    public void selectLast() {
        if (lastFlatEntries != null && !lastFlatEntries.isEmpty()) 
        {
            treeState.selectLast(lastFlatEntries.size() - 1);
        }
    }

    /**
     * Expands the currently selected node, or selects its first child if already expanded.
     */
    public void expandSelected() 
    {
        if (lastFlatEntries == null || lastFlatEntries.isEmpty()) 
        {
            return;
        }
        
        int idx = Math.min(treeState.selected(), lastFlatEntries.size() - 1);
        
        TreeNode<FileInfo> node = lastFlatEntries.get(idx).node();
        
        if (!node.isLeaf()) 
        {
            if (node.isExpanded()) 
            {
                if (!node.children().isEmpty() && idx + 1 < lastFlatEntries.size()) 
                {
                    treeState.select(idx + 1);
                }
            } 
            else 
            {
                node.expanded(true);
            }
        }
    }

    /**
     * Collapses the currently selected node, or jumps to the parent node if already collapsed.
     */
    public void collapseSelected() 
    {
        if (lastFlatEntries == null || lastFlatEntries.isEmpty()) 
        {
            return;
        }
        
        int idx = Math.min(treeState.selected(), lastFlatEntries.size() - 1);
        TreeWidget.FlatEntry<TreeNode<FileInfo>> entry = lastFlatEntries.get(idx);
        TreeNode<FileInfo> node = entry.node();
        
        if (node.isExpanded() && !node.isLeaf()) 
        {
            node.expanded(false);
        } 
        else 
        {
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

    /**
     * Toggles expansion of the currently selected directory node.
     */
    public void toggleSelected() 
    {
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
    public void enterSelected() {
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
     * Gets the FileInfo for the currently selected tree item.
     *
     * @return the selected FileInfo or null
     */
    public FileInfo getSelectedInfo() {
        if (lastFlatEntries == null || lastFlatEntries.isEmpty()) {
            return null;
        }
        int idx = Math.min(treeState.selected(), lastFlatEntries.size() - 1);
        TreeNode<FileInfo> node = lastFlatEntries.get(idx).node();
        return node.data();
    }

    public void currentDirectory() 
    {
        for(var modelFile : modelFiles)
        {
            Thread.ofVirtual().start(() -> 
            {
                try 
                {
                    // Same business logic - but now truly scalable
                    PngGenerator pngGenerator = new PngGenerator();

                    var runProfile = new RunProfile();
                    runProfile.executablePath = "/opt/openscad/OpenSCAD-2025.11.10.ai28923-x86_64.AppImage";
    
                    runProfile.mode = OpenScadCliTestSuite.RunMode.GENERATE_BASELINES;
   
                    var directoryProfile = new DirectoryProfile();
                    directoryProfile.setAutoCenter(true);
                    directoryProfile.setViewall(true);

                    System.out.println("currentPath = " + currentPath);    

                    Path openscadPath = createOpenscad(modelFile);
                    
                    var generationFlags = pngGenerator.generateDirectionalPngs(openscadPath, 
                            true, runProfile, directoryProfile);

                    var message = "processed and done: " + modelFile.toPath();

                    status = message;

                    System.out.println(message);                    
                } 
                catch (Exception e) 
                {
                    e.printStackTrace();
                }
            });
        }        
        System.out.println("Current Directory Not supported yet.");
    }

    public void recursiveDirectory() {
        System.out.println("Recursive Directory Not supported yet.");
    }

    public Path getCurrentPath() {
        return currentPath;
    }

    public List<TreeNode<FileInfo>> getRoots() {
        return Collections.unmodifiableList(roots);
    }

    public TreeState getTreeState() {
        return treeState;
    }

    public List<File> getModelFiles() {
        return Collections.unmodifiableList(modelFiles);
    }

    public List<TreeWidget.FlatEntry<TreeNode<FileInfo>>> getLastFlatEntries() {
        return lastFlatEntries;
    }

    public void setLastFlatEntries(List<TreeWidget.FlatEntry<TreeNode<FileInfo>>> lastFlatEntries) {
        this.lastFlatEntries = lastFlatEntries;
    }

    private Path createOpenscad(File modelFile) throws IOException 
    {
        var filename = modelFile.getName();
        
        var start = 0;
        var end = filename.length();
        
        var name = modelFile.getName().substring(start, end);
        
        var parentDirectory = modelFile.getParentFile();
        
        var openscadFilename = name + ".scad";
        
        File openscadFile = new File(parentDirectory, openscadFilename);

        var openscadScript = """

            import("%s");
                             
                             """.formatted(name);
        
        var openscadPath = openscadFile.toPath();
        
        Files.write(openscadPath, openscadScript.getBytes(), StandardOpenOption.CREATE);
        
        return openscadPath;
    }
}
