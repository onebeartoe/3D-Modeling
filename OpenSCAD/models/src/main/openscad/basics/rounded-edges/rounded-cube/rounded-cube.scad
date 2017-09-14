
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
module roundedCube(cornerRadius=4,
				   cubeCentered=false,
				   sides=30,
				   sidesOnly=false,
				   size=[20,20,2])
{
    $fn=sides;

    x = size[0] - cornerRadius/2;
    y = size[1] - cornerRadius/2;
    z = size[2];

    minkowski()
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
