
package org.onebeartoe.modeling.javascad;

import org.onebeartoe.modeling.openscad.test.suite.OpenScadTestSuiteTest;

/**
 *
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
}
