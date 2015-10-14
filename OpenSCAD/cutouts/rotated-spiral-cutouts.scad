
/**
  * This is a library for evenly spacted cutouts.
  */
module originalRotatedSpiralCutout(verticalSpacingFromBottom=0, 
                                   z=0,
								   charmCount = 6,
								   xyScale = 0.125,
								   charmStl = "../../../shapes/spurs/spurs-a.stl",
								   rowSpacing = 30)
{
	// outer spurs
	for ( i = [0 : charmCount-1] )
	{
		yTranslate = verticalSpacingFromBottom + (z*rowSpacing);
		
		rotate([
				90, 
				0,
				i * 360 / charmCount
		])
		// normally x,y,z - but here y moves the little spurs up and down
		translate([15, yTranslate, 30])
		scale([xyScale, xyScale, 20.2])
		import(charmStl);
	}	
}


module propossedRotatedSpiralCutout(spurStl = "../shapes/oshw/oshw.stl",
									charmCount = 16,
									xyScale = 0.4)
{
    for ( i = [0 : charmCount] )
    {	
        rotate([
                90, 
                0,
                i * 30
        ])
        // normally x,y,z - but here y moves the little spurs up and down
        translate([15, 5 * i, 30])
        scale([xyScale, xyScale, 20.2])
        import(spurStl);
    }
}