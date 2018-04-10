
package org.onebeartoe.modeling.opensacd.services;

import java.io.File;
import java.io.IOException;
import org.apache.commons.lang3.StringUtils;
import org.testng.annotations.Test;

/**
 *
 * @author Roberto Marquez
 */
public class ThingiverseCustomizerServiceSpecification
{
    ThingiverseCustomizerService implementation;
            
    public ThingiverseCustomizerServiceSpecification() throws IOException
    {
        implementation = new ThingiverseCustomizerService();
    }

    @Test(groups = "unit-tests")
    public void whenIncludesExistThenAllArePresentInInlined() throws IOException 
    {
        String inpath = "src/test/resources/client.scad";
        File scadFile = new File(inpath);
        String inlined = implementation.interpolateOpenScad(scadFile);
        
        assert inlined.contains("client()");
        
        assert inlined.contains("libA()");
        
        assert inlined.contains("libB()");
        
        String libC = "libC()";
        assert inlined.contains(libC);

        // lib A and B both include lib C, ensure lib C only appears once in the inlined version
        int matches = StringUtils.countMatches(inlined, libC);
        assert matches == 1;
    }
}
