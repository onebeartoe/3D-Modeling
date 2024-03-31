
package org.onebeartoe.modeling.openscad.test.suite.utils;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.onebeartoe.modeling.openscad.test.suite.MissingBaselinesException;
import org.onebeartoe.modeling.openscad.test.suite.model.GeneratePngBaselineResults;
import org.onebeartoe.modeling.openscad.test.suite.model.ImageComparisonResult;
import org.onebeartoe.modeling.openscad.test.suite.model.OneImageComparisonResult;
import org.onebeartoe.modeling.openscad.test.suite.model.OpenScadTestSuiteResults;
import org.onebeartoe.modeling.openscad.test.suite.model.RunProfile;
import static org.onebeartoe.modeling.openscad.test.suite.utils.PngGeneratorSpecification.missingBaseliesPath;
import static org.onebeartoe.modeling.openscad.test.suite.utils.PngGeneratorSpecification.openscadPath;
import static org.onebeartoe.modeling.openscad.test.suite.utils.PngGeneratorSpecification.simpleOpenScadPath;
import org.onebeartoe.system.Filesystem;
import static org.testng.Assert.assertFalse;
import static org.testng.Assert.assertNotNull;
import static org.testng.Assert.assertTrue;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

/**
 * This class test the specification for the OpenScadTestSuiteService specification.
 */
public class OpenScadTestSuiteServiceSpecification
{
    private OpenScadTestSuiteService implementation;

    private RunProfile runProfile;
    
    @BeforeTest
    public void initializeTest()
    {
        implementation = new OpenScadTestSuiteService();
        
        runProfile = new RunProfile();

        runProfile.executablePath = openscadPath();
        
        runProfile.openscadPaths = new ArrayList();        
    }
    
    @Test
    public void compareImages()
    {
        Path path = Paths.get(simpleOpenScadPath);
        
        runProfile.openscadPaths.add(path);
        
        ImageComparisonResult result = implementation.compareImages(runProfile);
        
        assertNotNull(result);
        
        assertTrue( result.successFiles.size() > 0 );
        
        assertFalse( result.exceptionThrown );
    }

    @Test(expectedExceptions = MissingBaselinesException.class)
    public void runTestSuite_missingBaselinesException() throws IOException, InterruptedException, MissingBaselinesException
    {
        runProfile.path = missingBaseliesPath;
//        Path path = Paths.get(missingBaseliesPath);
        
//        runProfile.openscadPaths.add(path);
        
        implementation.runTestSuite(runProfile);
    }    
    
    @Test
    public void generateProposedBaselines() throws IOException, InterruptedException
    {        
        GeneratePngBaselineResults results = implementation.generateProposedBaselines(runProfile);
        
        assertNotNull(results);
    }

    @Test
    public void longestComparisons()
    {
        String shortedDuration = "shortest.duration";
        String middleDuration = "middleduration";
        String longestDuration = "longest.duration";
        
        List<OneImageComparisonResult> errorFiles = new ArrayList();
        List<OneImageComparisonResult> successFiles = new ArrayList();
        
        OneImageComparisonResult shortestResult = new OneImageComparisonResult();
        shortestResult.setDuration(Duration.ZERO);
        shortestResult.setFile(shortedDuration);
        
        OneImageComparisonResult middleResult = new OneImageComparisonResult();
        middleResult.setDuration( Duration.ofHours(2) );
        middleResult.setFile(middleDuration);
        
        OneImageComparisonResult longestResult = new OneImageComparisonResult();
        longestResult.setDuration( Duration.ofDays(9) );
        longestResult.setFile(longestDuration);        
        
        errorFiles.add(longestResult);
        errorFiles.add(shortestResult);
        
        successFiles.add(middleResult);
        
        ImageComparisonResult compareResults = new ImageComparisonResult();
        compareResults.errorFiles = errorFiles;
        compareResults.successFiles = successFiles;       
                
        List<OneImageComparisonResult> sortedResults = implementation.longestComparisons(compareResults);
        
        assertTrue( sortedResults.get(0).getFile().equals(shortedDuration) );
        assertTrue( sortedResults.get(1).getFile().equals(middleDuration) );
        assertTrue( sortedResults.get(2).getFile().equals(longestDuration) );
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
        String pwd = Filesystem.pwd();
        
        System.out.println("pwd: " + pwd);

        // debug happy path is the following commented path
        runProfile.path = "../models/src/main/openscad/basics/primitives/cube";        
//        runProfile.path = "../models/src/main/openscad";

        OpenScadTestSuiteResults results = implementation.serviceRequest(runProfile);
                                
        assertNotNull(results);
    }
}
