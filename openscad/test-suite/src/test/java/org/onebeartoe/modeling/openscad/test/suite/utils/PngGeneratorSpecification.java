
package org.onebeartoe.modeling.openscad.test.suite.utils;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.onebeartoe.modeling.openscad.test.suite.model.GeneratePngBaselineResults;
import org.onebeartoe.modeling.openscad.test.suite.model.RunProfile;
import org.onebeartoe.system.OperatingSystem;
import static org.testng.Assert.assertFalse;
import static org.testng.Assert.assertTrue;
import static org.testng.AssertJUnit.assertEquals;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

/**
 * This class tests the specification for the PngGenerator class.
 */
public class PngGeneratorSpecification
{
    private PngGenerator implementation;
    
    public static final String simpleOpenScadPath = "src/test/resources/simple.scad";
        
    private RunProfile runProfile;
    
    public static final String macOpensacdPath = "/Applications/OpenSCAD-nightly.app/Contents/MacOS/OpenSCAD";
    
    @BeforeClass
    public void initializeTest()
    {
        implementation = new PngGenerator();
        
        runProfile = new RunProfile();

        runProfile.executablePath = openscadPath();
        
        List<Path> paths = new ArrayList();
        Path path = Paths.get(simpleOpenScadPath);
        paths.add(path);
        
        runProfile.openscadPaths = paths;        
    }
    
    @Test
    public void generatePngs() throws IOException, InterruptedException
    {        
        boolean forcePngGeneration = true;
        
        GeneratePngBaselineResults results = implementation.generatePngs(forcePngGeneration, runProfile);
        
        Map<Path, Duration> pathDurations = results.getPathDurations();
        int expected = 1;
        int actual  = pathDurations.size();
        assertEquals(actual, expected);
        
        assertTrue( results.isSuccess() );
    }

    @Test
    public void generatePngs_fail_badPath() throws IOException, InterruptedException
    {
        boolean forcePngGeneration = false;
        
        runProfile.openscadPaths.clear();
        String fakePath = "face/fake.scad";
        runProfile.openscadPaths.add( Paths.get(fakePath) );
        
        GeneratePngBaselineResults results = implementation.generatePngs(forcePngGeneration, runProfile);
        
        assertFalse( results.isSuccess() );
    }
    
    public static String openscadPath()
    {
        OperatingSystem os = new OperatingSystem();
        
        String executablePath;
        
        if( os.seemsLikeMac() )
        {
            executablePath = macOpensacdPath;
        }
        else
        {
//TODO: Look up if this value exists as an environment variable
            executablePath = "openscad";
        }

        return executablePath;
    }
}
