
package org.onebeartoe.modeling.openscad.test.suite;

/**
 *
 * @author Roberto Marquez
 */
public enum OpenScadCameraDirections
{
        TOP("  0,    0,    0"),  // looks like top is the default rotation
    BOTTTOM("180,    0,    0"),
       LEFT(" -90,   -180,   -90"),
      FRONT("  90,    0,    0");

    
    private String rotateParams; 
    
    OpenScadCameraDirections(String rotateParams)
    {
    	this.rotateParams = rotateParams;
    }
    
    public String getRotateParams()
    {
    	return rotateParams;
    }
}
