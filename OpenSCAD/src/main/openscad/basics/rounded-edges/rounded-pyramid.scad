
/**
 * 
 */
module roundedPyramid(h, r1, r2, cornerRadius, sides=30, sidesOnly=false)
//module roundedPyramid(size, cornerRadius, sides=30, sidesOnly=false)
{
	$fn=sides;
	
	minkowski()//size, cornerRadius)
	{
		cylinder(h=h, r1=r1, r2=r2, $fn=4);
	    
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
