
package org.onebeartoe.modeling.openscad.test.suite.utils;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.OpenOption;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.util.List;

/**
 *
 */
class ProgressionLogger 
{
    static final Path startsOutfile = Path.of("target/png.starts");
    
    static final Path finishesOutfile = Path.of("target/png.finishes");
    
    
    public static synchronized void startOf(String openscadPath) throws IOException 
    {       
//        var output = //"-starting-: " + 
//                openscadPath
//                
//                + "\n"
//                
//                ;
//        
//        Files.writeString(startsOutfile, 
//                            output, 
//                            StandardOpenOption.CREATE, StandardOpenOption.APPEND);
        output(startsOutfile, openscadPath);
    }
    
    private static synchronized void output(Path outpath, String openscadEntry) throws IOException
    {
        if( !outpath.toFile().exists() )
        {
            System.out.println("spam sysout until logging is configurable: " + openscadEntry);
        }
        else
        {
            var output = //"-starting-: " + 
                    openscadEntry                
                    + "\n"
                    ;        

            Files.writeString(outpath, 
                                output, 
                                StandardOpenOption.CREATE, StandardOpenOption.APPEND);
        }
    }

    public static synchronized  void finishOf(String openscadPath) throws IOException 
    {
//        var output = 
//                //"-finished-: " + 
//                openscadPath
//                + "\n"
//                
//                ;
//        
//        Files.writeString(finishesOutfile, 
//                            output, 
//                            StandardOpenOption.CREATE, StandardOpenOption.APPEND);
        output(finishesOutfile, openscadPath);
    }
}
