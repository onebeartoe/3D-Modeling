/**
  * This is a library for evenly spaced cutouts.
*/
module rotatedCutouts(charmCount = 16,
					  charmXYScales,
					  charmStls = ["../shapes/oshw/oshw.stl"],
					  charmIndcies = [],  // the vector of array index needs required
					  charmDepthScales,
					  yTranslateFactor = 5,
					  yTranslateMinimum = 0,
					  zRotationFactor = 30)
{
    for ( i = [0 : charmCount-1] )
    {

        single_rand = charmIndcies[i];

        charmIndex = round(single_rand);
        
		yTranslate = (i * yTranslateFactor) + yTranslateMinimum;
		
		zRotation = i * zRotationFactor;
		
        rotate([
                90, 
                0,
                zRotation
        ])
        // normally x,y,z - but here y moves the little spurs up and down
        translate([15, yTranslate, 30])
        scale([
		       charmXYScales[charmIndex], 
			   charmXYScales[charmIndex], 
			   charmDepthScales[charmIndex] //20.2])
			 ])
        import(charmStls[charmIndex]);
    }
}