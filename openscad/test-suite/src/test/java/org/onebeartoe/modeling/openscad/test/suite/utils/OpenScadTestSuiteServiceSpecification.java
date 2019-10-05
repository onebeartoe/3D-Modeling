
package org.onebeartoe.modeling.openscad.test.suite.utils;

import java.io.IOException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import org.onebeartoe.modeling.openscad.test.suite.model.GeneratePngBaselineResults;
import org.onebeartoe.modeling.openscad.test.suite.model.ImageComparisonResult;
import org.onebeartoe.modeling.openscad.test.suite.model.RunProfile;
import static org.testng.Assert.assertNotNull;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

/**
 * This class test the specification for the OpenScadTestSuiteService specification.
 */
public class OpenScadTestSuiteServiceSpecification
{
    private OpenScadTestSuiteService implementation;

    @BeforeClass
    public void initializeTest()
    {
        implementation = new OpenScadTestSuiteService();
    }
    
    @Test
    public void compareImages()
    {
        RunProfile runProfile = new RunProfile();
        
        runProfile.openscadPaths = new ArrayList();        
        
        ImageComparisonResult result = implementation.compareImages(runProfile);
        
        assertNotNull(result);
    }

    @Test
    public void generateProposedBaselines() throws IOException, InterruptedException
    {
        RunProfile runProfile = new RunProfile();
        
        runProfile.openscadPaths = new ArrayList();
        
        GeneratePngBaselineResults results = implementation.generateProposedBaselines(runProfile);
        
        assertNotNull(results);
    }
}
