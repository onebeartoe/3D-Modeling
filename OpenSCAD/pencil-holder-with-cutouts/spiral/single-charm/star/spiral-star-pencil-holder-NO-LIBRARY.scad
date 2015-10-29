

charmCount = 28; // [1:100]

charmXYScale = 0.9; // [0.1:5]

cupHeight = 150; // [75:300]

/* [Hidden] */
maxRandom = 0;
charmIndcies = rands(0,maxRandom, charmCount);


charmXYScales = rands(charmXYScale, charmXYScale, charmCount);

depthScale = 40.2;
charmDepthScales = rands(depthScale, depthScale, charmCount);

difference()
{
	cup(cupHeight=cupHeight);

	// uses the default value for the charmStls parameter
	rotatedCutouts(charmCount = charmCount,
				   charmIndcies = charmIndcies,
				   charmXYScales = charmXYScales,
				   charmDepthScales = charmDepthScales,
				   charmStls = ["../../../../shapes/star/star.stl"]);
}



//use <../../../../shapes/cup/cup.scad>;
/**
  * Create a cylindrical cup.
  */
module cup(cupHeight=70, innerRadius=53)
{
	difference()
	{
		centered = false;
	
		// outer part of the cup
		translate([0,0,0])
		cylinder (h = cupHeight, r=55, center = centered, $fn=100);
		
		// subtracted inner cup
		translate([0,0,5])
		cylinder (h = cupHeight, r=innerRadius, center = centered, $fn=100);
	}
}

//use <../../../../cutouts/rotated-spiral-cutouts.scad>;
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
//        import(charmStls[charmIndex])
		star(1);
    }
}

// from the OpenSCAD tutotials
module poly_Selection(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[9.080000,-22.000000],[10.922500,-17.093750],[12.213125,-14.728281],[13.890000,-13.020000],[15.773906,-12.298125],[18.041250,-12.022500],[22.500000,-11.910000],[34.390000,-10.968750],[40.862812,-10.133906],[45.500000,-9.000000],[28.500000,4.610000],[21.270000,12.170000],[22.870000,22.000000],[27.500000,43.000000],[8.500000,31.580000],[-0.500000,27.200000],[-10.500000,32.320000],[-28.500000,43.000000],[-22.870000,21.000000],[-21.690000,11.090000],[-28.500000,4.130000],[-45.500000,-11.000000],[-11.500000,-13.000000],[-0.500000,-43.000000],[2.289219,-38.828594],[4.908750,-33.096250],[9.080000,-22.000000]]);
  }
}

module star(h)
{

poly_Selection(h);
}