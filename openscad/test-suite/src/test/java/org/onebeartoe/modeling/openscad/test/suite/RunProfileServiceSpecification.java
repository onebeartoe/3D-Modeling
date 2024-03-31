
package org.onebeartoe.modeling.openscad.test.suite;

import java.io.File;
import org.apache.commons.cli.Options;
import static org.onebeartoe.modeling.openscad.test.suite.OpenScadCliTestSuite.buildOptions;
import org.onebeartoe.modeling.openscad.test.suite.model.RunProfile;
import static org.onebeartoe.modeling.openscad.test.suite.utils.PngGeneratorSpecification.simpleOpenScadPath;
import static org.onebeartoe.modeling.openscad.test.suite.utils.PngGeneratorSpecification.singleScadWithDependenciesPath;
import static org.testng.Assert.*;
import org.testng.annotations.Test;

/**
 *
 */
public class RunProfileServiceSpecification
{
    /**
     * Test of parseRunProfile method, of class RunProfileService.
     */
    @Test
    public void parseRunProfile_directoryPath() throws Exception 
    {
        var file = new File(simpleOpenScadPath);
        
        var parent = file.getParent();
        
        String[] args = {parent};

        Options options = buildOptions();

        RunProfile result = RunProfileService.parseRunProfile(args, options);
        
        assertFalse(result.singleScadWithDependenciesMode);
        
        var expectedCount = 1;
        
        var actualCount = result.openscadPaths.size();
        
        assertEquals(expectedCount, actualCount);
    }
    
    @Test
    public void parseRunProfile_singleScadPath() throws Exception 
    {
        String[] args = {singleScadWithDependenciesPath};

        Options options = buildOptions();

        RunProfile result = RunProfileService.parseRunProfile(args, options);
        
        assertEquals(result.openscadPaths.size(), 11);

        assertTrue(result.singleScadWithDependenciesMode);
    }    
}
