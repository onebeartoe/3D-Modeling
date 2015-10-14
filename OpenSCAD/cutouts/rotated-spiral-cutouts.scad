
// This is a library for evenly spacted cutouts.

spurStl = "../../../shapes/spurs/spurs-a.stl";

littleSpurCount = 6;

littleSpurScale = 0.125;

rowSpacing = 30;

module originalRotatedSpiralCutout(verticalSpacingFromBottom=0, z=0)
{
	// outer spurs
	for ( i = [0 : littleSpurCount-1] )
	{
		yTranslate = verticalSpacingFromBottom + (z*rowSpacing);
		
		rotate([
				90, 
				0,
				i * 360 / littleSpurCount
		])
		// normally x,y,z - but here y moves the little spurs up and down
		translate([15, yTranslate, 30])
		scale([littleSpurScale, littleSpurScale, 20.2])
		import(spurStl);
	}	
}

module propossedRotatedSpiralCutout()
{

}