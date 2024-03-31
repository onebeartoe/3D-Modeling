
package org.onebeartoe.modeling.opensacd.services;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.logging.Logger;
import org.apache.commons.lang3.StringUtils;
import org.onebeartoe.application.logging.SysoutLoggerFactory;
import static org.testng.AssertJUnit.assertTrue;
import org.testng.annotations.Test;

/**
 *
 * @author Roberto Marquez
 */
public class ThingiverseCustomizerServiceSpecification
{
    private ThingiverseCustomizerService implementation;
    
    private String clientPath = "src/test/resources/client.scad";
    
    private Logger logger;
            
    public ThingiverseCustomizerServiceSpecification() throws IOException
    {
        implementation = new ThingiverseCustomizerService();
        
        logger = SysoutLoggerFactory.getLogger( getClass().getName() );
    }
    
    @Test
    public void generateCustomizerFile() throws IOException
    {
        File resourceFile = new File(clientPath);
        Path resourcePath = resourceFile.toPath();
        
        Path clientOutPath = Paths.get("target/" + resourceFile.getName() );

        Files.copy(resourcePath, clientOutPath, StandardCopyOption.REPLACE_EXISTING);

        File resourceDir = resourceFile.getParentFile();
        
        File libAFile = new File(resourceDir, "lib-a.scad");
        Path libAPath = libAFile.toPath();
        Path libAOutPath = Paths.get("target/" + libAFile.getName() );
        Files.copy(libAPath, libAOutPath, StandardCopyOption.REPLACE_EXISTING);
        
        File libBFile = new File(resourceDir, "lib-b.scad");
        Path libBPath = libBFile.toPath();
        Path libBOutPath = Paths.get("target/" + libBFile.getName() );
        Files.copy(libBPath, libBOutPath, StandardCopyOption.REPLACE_EXISTING);

        File libCFile = new File(resourceDir, "lib-c.scad");
        Path libCPath = libCFile.toPath();
        Path libCOutPath = Paths.get("target/" + libCFile.getName() );
        Files.copy(libCPath, libCOutPath, StandardCopyOption.REPLACE_EXISTING);
        
        File openScadInfile = clientOutPath.toFile();
        
        File outfile = implementation.generateCustomizerFile(openScadInfile);
                
        assertTrue( outfile.exists() );

        String orignalName = openScadInfile.getName();
        String expectedName = orignalName + "-inlined.scad";        
        String actualName = outfile.getName();
        
        assertTrue( expectedName.equals(actualName) );
    }

    @Test
    public void whenIncludesExistThenAllArePresentInInlined() throws IOException 
    {
        File scadFile = new File(clientPath);

        var interpolated = implementation.interpolateOpenScad(scadFile);

        String inlined = interpolated.content;
        
        assertTrue( inlined.contains("client()") );
        
        assertTrue( inlined.contains("libA()") );
        
        assertTrue( inlined.contains("libB()") );
        
        String libC = "libC()";
        assertTrue( inlined.contains(libC) );

        // lib A and B both include lib C, ensure lib C only appears once in the inlined version
        int matches = StringUtils.countMatches(inlined, libC);
        assertTrue( matches == 1 );
    }
}
