
package org.onebeartoe.modeling.openscad.test.suite;

import java.util.logging.Level;
import java.util.logging.Logger;
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
        String path = "C:\\home\\owner\\versioning\\github\\3D-Modeling\\OpenSCAD\\src\\main\\openscad\\name-tags";
//        String path = ".";
        
        String [] args = {path};
        
        OpenScadTestSuite testSuite = new OpenScadTestSuite();
        try 
        {
            boolean redirectOpenscad = false;
            testSuite.serviceRequest(args, redirectOpenscad);
        } 
        catch (Exception ex) 
        {
            logger.log(Level.SEVERE, null, ex);
        }
    }
}
