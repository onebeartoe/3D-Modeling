
echo ("one-row-single-charm");

use <../../../cutouts/rotated-spiral-cutouts.scad>;

difference()
{
	// vase
	difference()
	{
		// outer vase
		translate([0,0,0])
		cylinder (h = 70, r=55, center = true, $fn=100);
		
		// remvoed inner vasecentered spur
		translate([0,0,5])
		cylinder (h = 70, r=50, center = true, $fn=100);
	}

	rotatedSpiralCutout();
}