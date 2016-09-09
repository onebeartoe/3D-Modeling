
/**
 * 
 *  some parts of this software were inspired by 
 *   	
 * 	     http://www.thingiverse.com/thing:9347
 * 
 */
 
boardLength = 100;

roundedCube([boardLength, boardLength, 1], 5, sides=20);

translate([0, 130, 0])
roundedCube([boardLength, boardLength, 1], 5, sides=20, sidesOnly=true);

/**
 * makes a rounded cube
 */
module roundedCube(size, cornerRadius, sides=30, sidesOnly=false)
{
	$fn=sides;
	
	x = size[0] - cornerRadius/2;
	y = size[1] - cornerRadius/2;
	z = size[2];
	
	minkowski(size, cornerRadius)
	{
	    cube(size=[x,y,z]);
	    
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
 