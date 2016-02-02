
package org.onebeartoe.modeling.openscad.test.suite;

/**
 *
 * @author Roberto Marquez
 */
public enum RenderViews
{	
    TOP("180,0,0"),
    BOTTTOM("180,0,0"),
    LEFT("0,0,0"),
    RIGHT("0,0,0");
    
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
