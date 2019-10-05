
package org.onebeartoe.modeling.openscad.test.suite.utils;

//import org.testng.annotations.BeforeMethod;
import java.io.IOException;
import org.onebeartoe.modeling.openscad.test.suite.model.GeneratePngBaselineResults;
import org.onebeartoe.modeling.openscad.test.suite.model.RunProfile;
import org.testng.Assert;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

/**
 * This class test the specification for the OpenScadTestSuiteService specification.
 */
public class OpenScadTestSuiteServiceSpecification
{
    private OpenScadTestSuiteService implementation;

    @BeforeMethod
    public void initializeTest()
    {
        implementation = new OpenScadTestSuiteService();
    }

    
    @Test
    public void generateProposedBaselines() throws IOException, InterruptedException
    {
        RunProfile runProfile = new RunProfile();
        
        GeneratePngBaselineResults results = implementation.generateProposedBaselines(runProfile);
        
        Assert.assertNotNull(results);
    }
}
