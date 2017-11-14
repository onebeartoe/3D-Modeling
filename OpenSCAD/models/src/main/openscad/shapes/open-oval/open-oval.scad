
//use <libraries/MCAD/shapes.scad>
use </usr/share/openscad/libraries/MCAD/shapes.scad>

module openOval()
{
	echo("before");
	openOval2d();
	echo("after");
}

/** Support functions and modules follow.  **/

module openOval2d(width = 20,
				  height = 10,
				  depth = 5,
				  borderThickness = 3)
{
	echo("before elipse");

	difference()
	{
		ellipticalCylinder(w = width, h = height, height = depth);

		w = width - borderThickness;
		h = height - borderThickness;
		translate([0, 0, -0.01])
		ellipticalCylinder(w = w, h = h, height = depth + 0.02);
	}

	echo("after elipse");
}
