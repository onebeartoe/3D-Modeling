
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
		
		zRotation = i * 360 / charmCount;
		
		rotate([
				90, 
				0,
				zRotation
		])
		// normally x,y,z - but here y moves the little spurs up and down
		translate([15, yTranslate, 30])
		scale([xyScale, xyScale, 20.2])
		import(charmStl);
	}	
}


module propossedRotatedSpiralCutout(charmCount = 16,
									xyScale = 0.4,
									charmStl = "../shapes/oshw/oshw.stl",
									yTranslateFactor = 5,
									zRotationFactor = 30)
{
    for ( i = [0 : charmCount] )
    {	
		yTranslate = i * yTranslateFactor;
		
		zRotation = i * zRotationFactor;
		
        rotate([
                90, 
                0,
                zRotation
        ])
        // normally x,y,z - but here y moves the little spurs up and down
        translate([15, yTranslate, 30])
        scale([xyScale, xyScale, 20.2])
        import(charmStl);
    }
}