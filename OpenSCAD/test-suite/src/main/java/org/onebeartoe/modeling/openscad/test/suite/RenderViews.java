
package org.onebeartoe.modeling.openscad.test.suite;

/**
 *
 * @author Roberto Marquez
 */
public enum RenderViews
{	
        TOP("  0,   0, 180"),
    BOTTTOM("180,   0,   0"),
       LEFT(" 90,  90,  90"),
      RIGHT("  0,   0,   0");
    
    private String rotateParams; 
    
    RenderViews(String rotateParams)
    {
	this.rotateParams = rotateParams;
    }
    
    public String getRotateParams()
    {
	return rotateParams;
    }
}
