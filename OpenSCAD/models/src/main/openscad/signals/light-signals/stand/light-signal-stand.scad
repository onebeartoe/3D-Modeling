
use <../light-signal.scad>

module lightSignalStand()
{
	union()
	{
		lightSignalStand_base();
	}
}

/** Support functions and modules follow. **/

module lightSignalStand_base()
{
	union()
	{
		radius = lightSignal_stlBaseOuterRadius() + 5;
		cylinder(r=radius, h=5, center=true);

		yTranslate = radius - 5;
		translate([0, yTranslate, 0])
		cube([5, 5, 75]);

		yTranslate2 = -yTranslate - 5;
		translate([0, yTranslate2, 0])
		cube([5, 5, 75]);
	}
}
