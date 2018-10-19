
package org.onebeartoe.modeling.openscad.test.suite.utils;

import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.PathMatcher;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.List;
import java.util.function.BiPredicate;
import java.util.stream.Collectors;
import java.util.stream.Stream;
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
    private PathMatcher matcher = null;

    public OpenScadFileFinder()
    {
        final String pattern = GlobalVariables.OPENSCAD_FILE_PATTERN;

        matcher = FileSystems.getDefault().getPathMatcher("glob:" + pattern);
    }

    private List<Path> find(Path inpath) throws IOException //throws Exception
    {
        System.out.println("Locating files under: " + inpath);
        System.out.println();
	
        int maxDepth = Integer.MAX_VALUE;
        
        BiPredicate<Path, BasicFileAttributes> matcherLambda = (p, bfa) ->
        {
            boolean matched = false;
            
            Path name = p.getFileName();
            
            if (bfa.isSymbolicLink())
            {
                System.out.format("Symbolic link: %s ", p);
            }
            else if (bfa.isRegularFile())
            {                
                if( name != null && matcher.matches(name) )
                {
                    matched = true;
                }
            }
            else if(bfa.isDirectory())
            {
                // ignore
            }
            else
            {
                System.out.format("Other: %s ", p);
            }

            return matched;
        };

        List<Path> find = null;
        
        try( Stream<Path> stream = Files.find(inpath, maxDepth, matcherLambda); )
        {
            find = stream.collect(Collectors.toList());
        }
        return find;
    }

    public List<Path> getFiles(Path inpath) throws Exception
    {
        List<Path> openscadPaths = 

            find(inpath);

        return openscadPaths;
    }
}