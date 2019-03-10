
use <../../../basics/rounded-edges/rounded-pyramid/rounded-pyramid.scad>

module streetLampBase(switchHole = "no")
{
	height = 30;
	radius1 = 32;
	radius2 = 28;
	sides=10;

	difference()
	{
		color("grey")
		roundedPyramid(h = height,
			 			r1 = radius1,
						r2 = radius2,
						sides = sides,
						sidesOnly=false);

		streetLampBase_cutouts(height = height, radius2 = radius2, switchHole = switchHole);
	}
}

module streetLampBase_cutouts(height, radius2, switchHole)
{
	// main chamber
	xy = radius2 + 13;
	z = height - 1;
	xyTranslate = -xy / 4.0;
	translate([0, 0, z/2.0])
	rotate([0, 0, 45])
	cube([xy, xy, z], center = true);

	// top hole
	cutoutRadius = radius2 - 14;
	cutoutHeight = height + 4;
	cylinder(r = cutoutRadius, h = cutoutHeight);

	if(switchHole == "yes")
	{
		streetLampBase_cutouts_switch();
	}
}

module streetLampBase_cutouts_switch()
{
	xLength = 50;
	yLength = 12;
	yTranslate = -yLength / 2.0;
	zTranslate = 10;
	translate([0, yTranslate, zTranslate])
	rotate([0,0,45])
	cube([xLength, yLength, 5]);
}
