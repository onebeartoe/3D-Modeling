
package org.onebeartoe.modeling.openscad.test.suite;

import java.nio.file.FileSystems;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.PathMatcher;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.ArrayList;
import java.util.List;

/**
 * This class is used to find .scad files under a given directory.
 * 
 * Each instance only looks up the files once, caches the results, and returns the cached
 * values if subsequent calls are made for the OpenSCAD files.   So if an up to date
 * listing is needed, then create a new instance of this class.
 * 
 * This class was build with guidance from the content at these URLs:
 * 
 *      https://docs.oracle.com/javase/tutorial/essential/io/examples/Find.java
 *      
 *      https://docs.oracle.com/javase/tutorial/essential/io/walk.html
 *      
 * @author Roberto Marquez
 */
public class OpenScadFileFinder extends SimpleFileVisitor<Path>
{
    private List<Path> openscadPaths;

    private Path inpath;

    private final PathMatcher matcher;

    public OpenScadFileFinder()
    {
        final String pattern = GlobalVariables.OPENSCAD_FILE_PATTERN;

        matcher = FileSystems.getDefault().getPathMatcher("glob:" + pattern);
    }

    private List<Path> find(Path inpath) throws Throwable
    {
        System.out.println("Locating files under: " + inpath);
        System.out.println();
	
        openscadPaths = new ArrayList<>();

        this.inpath = inpath;

        Files.walkFileTree(inpath, this);

        return openscadPaths;
    }

    public List<Path> getFiles(Path inpath) throws Throwable
    {
        if (openscadPaths == null)
        {
            find(inpath);
        }

        return openscadPaths;
    }

    @Override
    public FileVisitResult visitFile(Path file, BasicFileAttributes attr)
    {
        if (attr.isSymbolicLink())
        {
            System.out.format("Symbolic link: %s ", file);
        }
        else if (attr.isRegularFile())
        {
            Path name = file.getFileName();
            if (name != null && matcher.matches(name))
            {
                openscadPaths.add(file);
            }

        }
        else
        {
            System.out.format("Other: %s ", file);
        }

        return FileVisitResult.CONTINUE;
    }
}