
use <../../../shapes/open-cylinder/open-cylinder.scad>

module roundedChainLoop(height = 1,
	                    outerRadius = 10)
{
	difference()
	{
		openCylinder(height = height,
				 	 outerRadius = outerRadius);

		// top cutout
		radius = outerRadius * 0.95;
		zTranslate = height * 2.1;
		color("green")
		translate([0, 0, zTranslate])
		sphere(r = radius);

		// bottom cutout
		color("blue")
		translate([0, 0, -zTranslate + height])
		sphere(r = radius);
 	}
}
