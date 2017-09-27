/*
 */
package org.onebeartoe.modeling.openscad.test.suite.utils;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Roberto Marquez
 */
public class ImageComparisonResult
{
    public boolean exceptionThrown;
    
    public List<String> errorFiles;
    
    public ImageComparisonResult()
    {
        exceptionThrown = false;
        
        errorFiles = new ArrayList();
    }
}
