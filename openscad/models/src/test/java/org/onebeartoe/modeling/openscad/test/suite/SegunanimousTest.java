
package org.onebeartoe.modeling.openscad.test.suite;

import org.testng.annotations.Test;

/**
 * @author Roberto Marquez - https://github.com/onebeartoe
 */
public class SegunanimousTest extends OpenScadTestSuiteTest
{    
    protected String outputPath = "src/main/generated-openscad/";

    public SegunanimousTest() throws Exception
    {
        
    }
    
    @Test()
    public void test()
    {
        System.out.println("testguino");
    }

  //  @Override
    protected String getOutfileName()
    {
        return "unanimous.scad";
    }
    
    @Test()
    public void testSomething()
    {
        System.out.println("test something from " + getClass().getName());
    }    

    @Override
    public void willItWork()
    {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
