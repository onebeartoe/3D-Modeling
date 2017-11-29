
package org.onebeartoe.modeling.javascad.shapes.open.oval;

import eu.printingin3d.javascad.models.Abstract3dModel;
import org.onebeartoe.modeling.javascad.JavaScadTest;
import eu.printingin3d.javascad.models.Cube;

/**
 * @author Roberto Marquez - https://github.com/onebeartoe
 */
public class OpenOvalTest extends JavaScadTest
{
/**
borderThickness = 3,
				  depth = 5,
				  height = 10,
				  width = 20)
{
	difference()
	{
		ellipticalCylinder(w = width, h = height, height = depth);

		w = width - borderThickness;
		h = height - borderThickness;
		translate([0, 0, -0.01])
		ellipticalCylinder(w = w, h = h, height = depth + 0.02);
	}
 */    
    
    @Override
    protected Abstract3dModel getModel()
    {
        Abstract3dModel model = new Cube(50);
        
        return model;
    }

    @Override
    protected String getOutfileName()
    {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
