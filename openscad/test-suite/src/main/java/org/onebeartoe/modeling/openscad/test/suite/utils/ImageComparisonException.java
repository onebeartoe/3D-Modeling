
package org.onebeartoe.modeling.openscad.test.suite.utils;

/**
 * This exception class is thrown when a baseline image and proposed baseline image
 * comparison fails.
 */
public class ImageComparisonException extends Exception
{
    public ImageComparisonException(String message)
    {
        super(message);
    }    
}
