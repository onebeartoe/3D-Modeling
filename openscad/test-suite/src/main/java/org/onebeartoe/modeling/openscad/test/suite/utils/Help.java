
package org.onebeartoe.modeling.openscad.test.suite.utils;

import java.io.InputStream;
import org.onebeartoe.io.TextFileReader;

/**
 *
 * @author Roberto Marquez <https://www.youtube.com/user/onebeartoe>
 */
public class Help 
{
//TODO: why was this deprecated?    
//    @Deprecated
    public void printHelp() throws Exception
    {        
        String resourcePath = "/help.text";
   
        InputStream resourceAsStream = getClass().getResourceAsStream(resourcePath);
        String readText = TextFileReader.readText(resourceAsStream);

        System.out.println(readText);
    }    
}
