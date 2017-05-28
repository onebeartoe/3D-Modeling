
package org.onebeartoe.modeling.openscad.test.suite;

import org.testng.annotations.Test;

/**
 *
 * @author Roberto Marquez <https://www.youtube.com/user/onebeartoe>
 */
public class DataSetValidatorTests
{
    @Test(groups = {"validators"})
    public void missingBaselineFiles()
    {
        DataSetValidator dsv = new DataSetValidator();
        
        assert(true);
    }    
}
