
package org.onebeartoe.modeling.javascad.shapes.open.oval;

import eu.printingin3d.javascad.models.Extendable3dModel;
import eu.printingin3d.javascad.tranzitions.Difference;
import org.onebeartoe.modeling.javascad.shapes.ellipse.EllipticalCylinder;

/**
 * @author Roberto Marquez - https://github.com/onebeartoe
 */
public class OpenOval extends Extendable3dModel
{
    public OpenOval()
    {
        this(1,1);
    }

/**
    module openOval(borderThickness = 3,
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
    public OpenOval(int borderThickness, double depth)
    {
        int w = 5;
        int h = 10;        
        EllipticalCylinder block = new EllipticalCylinder(w,h, depth);
        
        int cw = w - borderThickness;
        int ch = h - borderThickness;
        EllipticalCylinder cutout = new EllipticalCylinder(cw, ch, depth + 0.02);
                
        Difference difference = new Difference(block, cutout);
        
        baseModel = difference;
    }
}
