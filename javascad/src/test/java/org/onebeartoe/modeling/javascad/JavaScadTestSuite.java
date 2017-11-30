
package org.onebeartoe.modeling.javascad;

import org.onebeartoe.modeling.openscad.test.suite.OpenScadTestSuiteTest;
import org.testng.annotations.Test;

/**
 * @author Roberto Marquez
 */
public class JavaScadTestSuite extends OpenScadTestSuiteTest
{
    String w = "w";
    
    public JavaScadTestSuite() throws Exception
    {
        super();
        
        System.out.println();
        
    }
    
    protected String getRootTargetPath()
    {
        return "src/main/generated-openscad/";
    }
    
    @Test()
    public void testSomething()
    {
        System.out.println("test something from " + getClass().getName());
    }
    

    @Test(groups = {"openscad-test-suite"})
    public void testW()
    {
        System.out.println("hi from test b");
    }    

    @Override
    public void willItWork()
    {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
