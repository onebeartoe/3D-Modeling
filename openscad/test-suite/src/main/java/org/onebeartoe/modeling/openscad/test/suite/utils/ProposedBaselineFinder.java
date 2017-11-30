
package org.onebeartoe.modeling.openscad.test.suite.utils;

import java.io.File;
import java.io.IOException;
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
 * @author Roberto Marquez <https://www.youtube.com/user/onebeartoe>
 */
public class ProposedBaselineFinder extends SimpleFileVisitor<Path>
{
    private List<File> baselines;
                    
    public List<File> find(Path inpath) throws IOException
    {
        baselines = new ArrayList();
        
        Files.walkFileTree(inpath, this);
        
        return baselines;
    }
    
    @Override
    public FileVisitResult visitFile(Path file, BasicFileAttributes attr)
    {
        if (attr.isRegularFile())
        {
            final String pattern = "*-proposed-baseline.png";
            PathMatcher matcher = FileSystems.getDefault().getPathMatcher("glob:" + pattern);
            
            Path name = file.getFileName();
            
            if (name != null && matcher.matches(name))
            {
                baselines.add( file.toFile() );
            }
        }

        return FileVisitResult.CONTINUE;
    }
}
