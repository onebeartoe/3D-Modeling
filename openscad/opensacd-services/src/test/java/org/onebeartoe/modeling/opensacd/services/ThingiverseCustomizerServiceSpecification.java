
package org.onebeartoe.modeling.opensacd.services;

import java.io.File;
import java.io.IOException;
import java.util.logging.Logger;
import org.apache.commons.lang3.StringUtils;
import org.onebeartoe.application.logging.SysoutLoggerFactory;
import static org.testng.AssertJUnit.assertTrue;
import org.testng.annotations.Test;
//import org.testng.log4testng.Logger;

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
        
//        logger = Logger.getLogger( getClass().getName() );
//        logger.setUseParentHandlers(false);
    }
    
    @Test
    public void generateCustomizerFile() throws IOException
    {
logger.info(">some mesage<");
System.out.println(">plooop<");
        File openScadInfile = new File(clientPath);
        
        File outfile = implementation.generateCustomizerFile(openScadInfile);
                
        assertTrue( outfile.exists() );
logger.severe("it's fatal!");
        String orignalName = openScadInfile.getName();
        String expectedName = orignalName + "-inlined.scad";        
        String actualName = outfile.getName();
        
        assertTrue( expectedName.equals(actualName) );
    }

    @Test
    public void whenIncludesExistThenAllArePresentInInlined() throws IOException 
    {
        File scadFile = new File(clientPath);
        String inlined = implementation.interpolateOpenScad(scadFile);
        
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
