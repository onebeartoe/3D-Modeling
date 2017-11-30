/*

 */
package org.onebeartoe.modeling.openscad.test.suite.utils;

import java.io.InputStream;
import java.net.URI;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import org.onebeartoe.io.TextFileReader;
import org.onebeartoe.modeling.openscad.test.suite.OpenScadTestSuite;

/**
 *
 * @author Roberto Marquez <https://www.youtube.com/user/onebeartoe>
 */
public class Help 
{
    @Deprecated
    public void printHelp() throws Exception
    {
        int w= 3;
        
//        StringBuilder message = new StringBuilder();

//        String resourcePath = "help.text";
        String resourcePath = "/help.text";

        
        
        InputStream resourceAsStream = getClass().getResourceAsStream(resourcePath);
        String readText = TextFileReader.readText(resourceAsStream);
                
                
        
//        URL url = getClass().getResource(resourcePath);
//        
//        URI uri = url.toURI();
//
//        Path inpath = Paths.get(uri);
//
//        List<String> allLines = Files.readAllLines(inpath);
//
//        allLines.forEach((line) -> {
//            message.append(line);
//            message.append(System.lineSeparator());
//        });

        System.out.println(readText);
//        System.out.println(message);
    }    
}
