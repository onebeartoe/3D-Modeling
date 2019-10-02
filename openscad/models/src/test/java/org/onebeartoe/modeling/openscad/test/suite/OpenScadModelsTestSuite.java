/*
 */
package org.onebeartoe.modeling.openscad.test.suite;

import static org.testng.AssertJUnit.assertTrue;
import org.testng.annotations.Test;

/**
 *
 * @author Roberto Marquez
 */
public class OpenScadModelsTestSuite extends OpenScadTestSuiteTest
{
    public OpenScadModelsTestSuite() throws Exception
    {
        
    }

    @Override
    public void willItWork()
    {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    @Test
    public void someTest()
    {
        logger.info("some test is called");
        
//TODO: remove this once the test is working
        assertTrue(5 == 5);
    }    
}
