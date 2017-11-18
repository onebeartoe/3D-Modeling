
package org.onebeartoe.modeling.openscad.test.suite.utils;

import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.FileVisitResult;
import java.nio.file.FileVisitor;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.PathMatcher;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.ArrayList;
import java.util.List;
import java.util.function.BiPredicate;
import org.onebeartoe.modeling.openscad.test.suite.GlobalVariables;

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
//    private List<Path> openscadPaths;

//    private Path inpath;

    private final PathMatcher matcher;

    public OpenScadFileFinder()
    {
        final String pattern = GlobalVariables.OPENSCAD_FILE_PATTERN;

        matcher = FileSystems.getDefault().getPathMatcher("glob:" + pattern);
    }

    private List<Path> find(Path inpath) throws Exception
    {
        System.out.println("Locating files under: " + inpath);
        System.out.println();
	
        List<Path> openscadPaths = new ArrayList<>();

        Files.walkFileTree(inpath, new FileVisitor<Path>() 
        {
            @Override
            public FileVisitResult preVisitDirectory(Path dir, BasicFileAttributes attrs) throws IOException 
            {
                return FileVisitResult.CONTINUE;
            }

            @Override
            public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException 
            {
                if (attrs.isSymbolicLink())
                {
                    System.out.format("Symbolic link: %s ", file);
                }
                else if (attrs.isRegularFile())
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

            @Override
            public FileVisitResult visitFileFailed(Path file, IOException exc) throws IOException {
                return FileVisitResult.CONTINUE;
            }

            @Override
            public FileVisitResult postVisitDirectory(Path dir, IOException exc) throws IOException 
            {
                return FileVisitResult.CONTINUE;
            }
        } );

        return openscadPaths;
    }

    public List<Path> getFiles(Path inpath) throws Exception
    {
        List<Path> openscadPaths = 

            find(inpath);

        return openscadPaths;
    }
}