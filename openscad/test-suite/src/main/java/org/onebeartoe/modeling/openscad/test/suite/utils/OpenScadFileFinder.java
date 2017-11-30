
package org.onebeartoe.modeling.openscad.test.suite.utils;

import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.PathMatcher;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.List;
import java.util.function.BiPredicate;
import java.util.stream.Collectors;
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

    private List<Path> find(Path inpath) throws Exception
    {
        System.out.println("Locating files under: " + inpath);
        System.out.println();
	
//        List<Path> openscadPaths = new ArrayList<>();

        int maxDepth = Integer.MAX_VALUE;
        
        BiPredicate<Path, BasicFileAttributes> matcherLambda = (p, bfa) ->
        {
            boolean matched = false;
            
            Path name = p.getFileName();

//            System.out.println("trying to match: " + name);
            
            if (bfa.isSymbolicLink())
            {
                System.out.format("Symbolic link: %s ", p);
            }
            else if (bfa.isRegularFile())
            {
//                System.out.println("regular file: " + name);
                
                if( name != null && matcher.matches(name) )
                {
//                    System.out.println("match: " + name);
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
        
        List<Path> find = Files.find(inpath, maxDepth, matcherLambda)
                .collect(Collectors.toList());

        return find;
    }

    public List<Path> getFiles(Path inpath) throws Exception
    {
        List<Path> openscadPaths = 

            find(inpath);

        return openscadPaths;
    }
}