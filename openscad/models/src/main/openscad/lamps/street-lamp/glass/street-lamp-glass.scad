
use <../base/street-lamp-base.scad>

import("/Users/lando/Versioning/world/betoland-world/3d-relization/models/street-lamps/WillemvD/files/StreetLampGlass.stl");

module streetLampGlass(bottomRadius = 15.01,
					   bottomHoleRadius = 5,
					   height = 30.01,
					   shellThickness = 1.2,
					   sides = 6,
				   	   topRadius = 20.01)
{
	difference()
	{
		// outer shell
		cylinder(h = height, r1=bottomRadius, r2=topRadius, $fn=sides);

		streetLampGlass_cutouts(bottomRadius = bottomRadius,
								bottomHoleRadius = bottomHoleRadius,
								height = height,
								shellThickness = shellThickness,
								sides = sides,
						   	   	topRadius = topRadius);
	}
}

module streetLampGlass_cutouts(bottomRadius,
							   bottomHoleRadius,
							   height,
							   shellThickness,
							   sides,
						   	   topRadius)
{
	// inner cutout
	zTranslate = shellThickness + 0.01;
	translate([0, 0, zTranslate])
	cylinder(h = height - shellThickness,
			 r1 = bottomRadius - shellThickness,
			 r2 = topRadius - shellThickness,
			 $fn = sides);

	 // bottom hole
	 translate([0,0, -0.01])
	 cylinder(h = shellThickness + 0.03,
	 		  r1 = bottomHoleRadius,
		  	  r2 = bottomHoleRadius,
			  $fn = 20);
}
