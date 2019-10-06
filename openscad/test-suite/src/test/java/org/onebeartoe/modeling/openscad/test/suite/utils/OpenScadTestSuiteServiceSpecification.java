
package org.onebeartoe.modeling.openscad.test.suite.utils;

import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Map;
import java.util.Set;
import org.onebeartoe.modeling.openscad.test.suite.model.GeneratePngBaselineResults;
import org.onebeartoe.modeling.openscad.test.suite.model.ImageComparisonResult;
import org.onebeartoe.modeling.openscad.test.suite.model.OpenScadTestSuiteResults;
import org.onebeartoe.modeling.openscad.test.suite.model.RunProfile;
import static org.testng.Assert.assertNotNull;
import static org.testng.Assert.assertTrue;
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

    @Test
    public void proposedPngGenerationDurations()
    {
        GeneratePngBaselineResults results = new GeneratePngBaselineResults();
        
        String shortedDuration = "shortest.duration";
        String middleDuration = "middleduration";
        String longestDuration = "longest.duration";
        
        Path path1 = Paths.get(shortedDuration);
        Path path2 = Paths.get(middleDuration);
        Path path3 = Paths.get(longestDuration);
        
        results.addPathDuration(path3, Duration.ofDays(9));
        results.addPathDuration(path1, Duration.ZERO);
        results.addPathDuration(path2, Duration.ofHours(2));
                
        Map<Path, Duration> sortedReslts = implementation.proposedPngGenerationDurations(results); 
        
        Set<Path> keySet = sortedReslts.keySet();
        
        Path [] type = {};
        
        Path [] keys = keySet.toArray(type);
        
        assertTrue( keys[0].toString().equals(shortedDuration) );
        assertTrue( keys[1].toString().equals(middleDuration) );
        assertTrue( keys[2].toString().equals(longestDuration) );
    }
    
    @Test
    public void serviceRequest() throws Exception
    {
        RunProfile runProfile = new RunProfile();

Path path = FileSystems.getDefault().getPath(".").toAbsolutePath();
System.out.println("pwd: " + path.toString());        
        
        runProfile.path = "../models/src/main/openscad/basics/primitives/cube";
        
        runProfile.executablePath = "openscad";
        
        runProfile.openscadPaths = new ArrayList();
        
        OpenScadTestSuiteResults results = implementation.serviceRequest(runProfile);
                                
        assertNotNull(results);
    }
}
