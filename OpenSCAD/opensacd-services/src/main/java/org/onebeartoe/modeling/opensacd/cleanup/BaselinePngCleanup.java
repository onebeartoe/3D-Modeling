
package org.onebeartoe.modeling.opensacd.cleanup;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;

/**
 *
 * @author Roberto Marquez <https://www.youtube.com/user/onebeartoe>
 */
public class BaselinePngCleanup 
{
    public static void main(String [] args) throws IOException
    {
        // This path represens a pre-prepared file containing a list of files to delete.
        Path inpath = Paths.get("C:\\home\\owner\\versioning\\github\\3D-Modeling\\target-files.text");
        
        List<String> removeCommands;
        try (BufferedReader reader = Files.newBufferedReader(inpath)) 
        {           
            removeCommands = reader.lines()                                       
                               .map( l -> l.trim() )
                               .filter( p -> p.endsWith("BOTTOM-baseline.png") )
                               .map(p -> "rm " + p)
                               .collect( Collectors.toList() );

            removeCommands.forEach(System.out::println);
            System.out.println("Number of paths = " + removeCommands.size() );
        }
        
        File parent = inpath.getParent().toFile();
        String fileName = "remove-" + inpath.getFileName().toString();
        File outfile = new File(parent, fileName);

        System.out.println("ouffile: " + outfile.getAbsolutePath() );

        Path outpath = outfile.toPath();
        Files.write(outpath, removeCommands, StandardCharsets.US_ASCII);
    }
}