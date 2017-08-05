
package org.onebeartoe.modeling.openscad.test.suite;

import java.util.logging.Level;
import java.util.logging.Logger;
import org.onebeartoe.modeling.openscad.test.suite.utils.OpenScadTestSuiteService;
import org.testng.annotations.Test;

/**
 *
 * @author Roberto Marquez <https://www.youtube.com/user/onebeartoe>
 */
public class OpenScadTestSuiteTest 
{
    private Logger logger;
    
    public OpenScadTestSuiteTest()
    {
        logger = Logger.getLogger( getClass().getName() );
    }
    
    
    
    @Test(groups = {"test-suite"})
    public void testSuite()
    {
//        String path = "../../../../../../../../../../src/main/openscad/name-tags";
//        String path = 
//        String path = ".";
        
//        String [] args = {path};
        
        OpenScadTestSuiteService testSuite = new OpenScadTestSuiteService();
        try 
        {
            RunProfile runProfile = new RunProfile();
            runProfile.path = "../library/src/main/openscad/name-tags/";
            runProfile.redirectOpenscad = false;
            testSuite.serviceRequest(runProfile);
        } 
        catch (Exception ex) 
        {
            logger.log(Level.SEVERE, null, ex);
        }
    }
}
