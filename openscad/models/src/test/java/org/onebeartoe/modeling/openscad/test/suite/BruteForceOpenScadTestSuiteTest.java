
package org.onebeartoe.modeling.openscad.test.suite;

import java.io.IOException;
import org.onebeartoe.modeling.openscad.test.suite.model.RunProfile;
import java.util.logging.Logger;
import org.onebeartoe.modeling.openscad.test.suite.utils.ImageComparisonException;

import org.onebeartoe.modeling.openscad.test.suite.utils.OpenScadTestSuiteService;
import org.testng.annotations.Test;

/**
 * This class shows how to run the test suit on a select directory; i.e. a sub-directory
 * of the OpenSCAD library in this repository.
 * 
 * See the Javadoc on the test method for information on how to enable it.
 * 
 * @author Roberto Marquez <https://www.youtube.com/user/onebeartoe>
 */
public class BruteForceOpenScadTestSuiteTest 
{
//TODO: is this class even needed anymore?    
    
    
    private Logger logger;
    
    public BruteForceOpenScadTestSuiteTest()
    {
        logger = Logger.getLogger( getClass().getName() );
    }

    /**
     * To enable this test, set the enabled value to true.
     * 
     * @throws Exception 
     */
    @Test(enabled = false)
    public void testSuite() throws IOException, ImageComparisonException, InterruptedException
    {        
        OpenScadTestSuiteService testSuite = new OpenScadTestSuiteService();

        RunProfile runProfile = new RunProfile();

        runProfile.executablePath = "openscad";

        runProfile.path = "src/main/openscad/basics/";
        
        runProfile.redirectOpenscad = false;
        
        testSuite.serviceRequest(runProfile);
    }
}
