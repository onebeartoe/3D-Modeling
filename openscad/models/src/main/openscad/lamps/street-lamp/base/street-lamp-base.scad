
use <../../../basics/rounded-edges/rounded-pyramid/rounded-pyramid.scad>

module streetLampBase(switchHole = "no")
{
	height = 30;
	radius1 = 32;
	radius2 = 28;
	sides=10;

	difference()
	{
		streetLampBase_outerShell(height = height,
		radius1 = radius1,
		radius2 = radius2,
		sides = sides);

		streetLampBase_cutouts(height = height, radius1 = radius1, radius2 = radius2, sides = sides, switchHole = switchHole);
	}
}

module streetLampBase_outerShell(height,
radius1,
radius2,
sides)
{
	color("grey")
	roundedPyramid(h = height,
					r1 = radius1,
					r2 = radius2,
					sides = sides,
					sidesOnly=false);
}

module streetLampBase_cutouts(height, radius1, radius2, sides, switchHole)
{
	// main chamber
	xy = radius2 + 13;
	xyTranslate = -xy / 4.0;
	zTranslate = 2.0;
	xyzScale = 0.9;
	outerShellHeight = height - 2;
	translate([0, 0, zTranslate])
	rotate([0, 0, 0])
	scale([xyzScale, xyzScale, xyzScale])
	streetLampBase_outerShell(height = outerShellHeight, radius1 = radius1, radius2 = radius2, sides = sides);

	// top hole
	cutoutRadius = radius2 - 14;
	cutoutHeight = height + 4;
	translate([0, 0, zTranslate])
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
