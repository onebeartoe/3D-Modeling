/*
 */
package org.onebeartoe.modeling.openscad.test.suite.model;

import org.onebeartoe.modeling.openscad.test.suite.model.OneImageComparisonResult;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Roberto Marquez
 */
public class ImageComparisonResult
{
    public boolean exceptionThrown;
    
    public List<OneImageComparisonResult> errorFiles;
    
    public List<OneImageComparisonResult> successFiles;
    
    public ImageComparisonResult()
    {
        exceptionThrown = false;
        
        errorFiles = new ArrayList();
        
        successFiles = new ArrayList();
    }
}
