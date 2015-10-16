
/**
  * This is a library for evenly spacted cutouts.
*/
module propossedRotatedSpiralCutout(charmCount = 16,
									xyScale = 0.4,
									charmStl = "../shapes/oshw/oshw.stl",
									yTranslateFactor = 5,
									yTranslateMinimum = 0,
									zRotationFactor = 30)
{
    for ( i = [0 : charmCount] )
    {	
		yTranslate = (i * yTranslateFactor) + yTranslateMinimum;
		
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