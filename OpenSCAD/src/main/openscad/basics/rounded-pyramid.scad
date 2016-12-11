
// this one is shaped like a desktop keyboard keycap.
color("grey")
translate([0, 130, 0])
roundedPyramid(5, sides=20, sidesOnly=true);

// this one has rounded a top/bottom as well as rounded sides.
color("orange")
roundedPyramid(5, sides=20);

/**
 * 
 */
module roundedPyramid(cornerRadius, sides=30, sidesOnly=false)
//module roundedPyramid(size, cornerRadius, sides=30, sidesOnly=false)
{
	$fn=sides;
	
	minkowski()//size, cornerRadius)
	{
		cylinder(20,20,10,$fn=4);
	    
	    if(sidesOnly)
	    {
	    	cylinder(r=cornerRadius);
	    }
	    else
	    {
	    	sphere(r=cornerRadius);
	    	
    	}
	}	
}
