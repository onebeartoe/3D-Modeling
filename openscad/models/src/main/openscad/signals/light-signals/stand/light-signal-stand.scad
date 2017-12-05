
use <../light-signal.scad>

module lightSignalStand()
{
	difference()
	{
		postHeight = 75;

		lightSignalStand_base(postHeight);

		lightSignalStand_mountingHoles(postHeight);
	}
}

/** Support functions and modules follow. **/

module lightSignalStand_base(postHeight)
{
	union()
	{
		radius = lightSignal_stlBaseOuterRadius() + 5;
		cylinder(r=radius, h=5, center=true);

		xLength = 12;
		xTranslate = -xLength / 2.0;
		yTranslate = radius - 5;
		translate([xTranslate, yTranslate, 0])
		cube([xLength, 5, postHeight]);

		yTranslate2 = -yTranslate - 5;
		translate([xTranslate, yTranslate2, 0])
		cube([xLength, 5, postHeight]);
	}
}

module lightSignalStand_mountingHoles(postHeight)
{
	radius = lightSignal_mountingPostRadius() + 0.6;
	zTranslate = postHeight * 0.7;
	translate([0, 0, zTranslate])
	rotate([90,0,0])
	cylinder(r=radius, h=100, center=true);
}
