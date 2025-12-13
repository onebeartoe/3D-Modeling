
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
        Files.writeString(startsOutfile, 
                            openscadPath, 
                            StandardOpenOption.CREATE, StandardOpenOption.APPEND);
    }

    public static synchronized  void finishOf(String openscadPath) throws IOException 
    {
        Files.writeString(finishesOutfile, 
                            openscadPath, 
                            StandardOpenOption.CREATE, StandardOpenOption.APPEND);
    }
}
