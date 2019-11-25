
/**
 * 
 */
module roundedPyramid(h, 
					  r1, 
					  r2, 
					  cornerRadius,
//TODO: clarify this parameter
					  cylinderFn = 4,					  
					  sides=30, 
					  sidesOnly=false)
{
//TODO: clarify this parameter
	$fn=sides;
	
	minkowski()
	{
		cylinder(h=h, r1=r1, r2=r2, $fn=cylinderFn);
	    
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
