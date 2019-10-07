
package org.onebeartoe.modeling.opensacd.services;

import java.io.File;
import java.io.IOException;
import org.apache.commons.lang3.StringUtils;
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
            
    public ThingiverseCustomizerServiceSpecification() throws IOException
    {
        implementation = new ThingiverseCustomizerService();
    }
    
    @Test
    public void generateCustomizerFile() throws IOException
    {
        File openScadInfile = new File(clientPath);
        
        File outfile = implementation.generateCustomizerFile(openScadInfile);
                
        assertTrue( outfile.exists() );
        
        String orignalName = openScadInfile.getName();
        String expectedName = orignalName + "-inlined.scad";        
        String actualName = outfile.getName();
        
        assertTrue( expectedName.equals(actualName) );
    }

    @Test(groups = "unit-tests")
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
