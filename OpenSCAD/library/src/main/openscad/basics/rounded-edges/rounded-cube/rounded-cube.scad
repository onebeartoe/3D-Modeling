
/**
 * 
 *  some parts of this software were inspired by 
 *   	
 * 	     http://www.thingiverse.com/thing:9347
 * 
 */
 
/**
 * makes a rounded cube
 */
module roundedCube(size=[20,20,2], cornerRadius=4, sides=30, sidesOnly=false, cubeCentered=false)
{
    $fn=sides;

    x = size[0] - cornerRadius/2;
    y = size[1] - cornerRadius/2;
    z = size[2];

    minkowski(size, cornerRadius)
    {
        cube(size=[x,y,z], center=cubeCentered);

        if(sidesOnly)
        {
            cylinder(r=cornerRadius);
        }
        else
        {
            sphere(r=cornerRadius);	    	
        }
    };
}