
/**
  * This is a library for evenly spacted cutouts.
*/
module rotatedCutouts(charmCount = 16,
									charmXYScale = 0.4,
									charmStls = ["../shapes/oshw/oshw.stl"],
									charmIndcies = [],  // the vector of array index needs required
									yTranslateFactor = 5,
									yTranslateMinimum = 0,
									zRotationFactor = 30)
{
	if(len(charmIndcies) == 0)
	{
		echo("we hvae no charm indecies");
	}

//echo("FIX THIS!  IT IS USING THE WROING CHARM COUNT.  IT SHOULD BE charmCount -1 ");	
    for ( i = [0 : charmCount-1] )
    {

        single_rand = charmIndcies[i];

        charmIndex = round(single_rand);
        
//echo(charmIndex);
	
		yTranslate = (i * yTranslateFactor) + yTranslateMinimum;
		
		zRotation = i * zRotationFactor;
		
        rotate([
                90, 
                0,
                zRotation
        ])
        // normally x,y,z - but here y moves the little spurs up and down
        translate([15, yTranslate, 30])
        scale([charmXYScale, 
			   charmXYScale, 
			   20.2])
        import(charmStls[charmIndex]);
    }
}