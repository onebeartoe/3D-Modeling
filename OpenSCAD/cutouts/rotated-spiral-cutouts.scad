
echo ("in rotated sprial coutes .scsd");

// This is a library for evenly spacted cutouts.

spurStl = "../../../shapes/spurs/spurs-a.stl";

littleSpurCount = 6;

littleSpurScale = 0.125;

rowSpacing = 30;

module rotatedSpiralCutout()
//module rotatedSpiralCutout(z=0)
{
	echo("z: ", z);

	// outer spurs
	for ( i = [0 : 5] )
	{		
		rotate([
				90, 
				0,
				i * 360 / 6
		])
		// normally x,y,z - but here y moves the little spurs up and down
		translate([15, 15+(z*rowSpacing), 30])
		scale([littleSpurScale, littleSpurScale, 20.2])
		import(spurStl);
	}	
}