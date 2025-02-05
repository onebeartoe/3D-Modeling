
use <MCAD/shapes.scad>
//use </usr/share/openscad/libraries/MCAD/shapes.scad>
//use </Applications/OpenSCAD.app/Contents/Resources/libraries/MCAD/shapes.scad>

module openOval(borderThickness = 3, xLength = 20, yLength = 10, zLength = 1)
{
	openOval2d(borderThickness = borderThickness,
			   depth = zLength,
			   width = xLength,
			   height = yLength);
}

/** Support functions and modules follow.  **/

module openOval2d(borderThickness = 3,
				  depth = 5,
				  height = 10,
				  width = 20)
{
	difference()
	{
		ellipticalCylinder(w = width, h = height, height = depth);

		w = width - borderThickness;
		h = height - borderThickness;
		translate([0, 0, -0.02])
		ellipticalCylinder(w = w, h = h, height = depth + 0.1);
	}
}
