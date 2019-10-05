
package org.onebeartoe.modeling.openscad.test.suite.utils;

import java.io.IOException;
import java.util.ArrayList;
import org.onebeartoe.modeling.openscad.test.suite.model.GeneratePngBaselineResults;
import org.onebeartoe.modeling.openscad.test.suite.model.RunProfile;
import org.testng.Assert;
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
    public void generateProposedBaselines() throws IOException, InterruptedException
    {
        RunProfile runProfile = new RunProfile();
        
        runProfile.openscadPaths = new ArrayList();
        
        GeneratePngBaselineResults results = implementation.generateProposedBaselines(runProfile);
        
        Assert.assertNotNull(results);
    }
}
