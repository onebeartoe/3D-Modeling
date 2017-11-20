
use <../open-oval/open-oval.scad>

use <MCAD/triangles.scad>

module dialogBubble(trangleRotateZ = 25,
					yLength = 10)
{
	difference()
	{
		dialogBubble_block(trangleRotateZ,
							yLength);

		dialogBubble_cutouts();
	}
}

/** Support functions and modules follow.  **/

module dialogBubble_block(trangleRotateZ, yLength)
{
	union()
	{
//		% // transparent
		openOval(yLength = yLength);

		yTranslate = -5;
		yTranslate = -yLength + 5;

		rotateZ = trangleRotateZ;
		translate([15, yTranslate, 0])
		rotate([0, 0, rotateZ])
		triangle(o_len = -8, a_len = -5, depth=5);
	}
}

module dialogBubble_cutouts(trangleRotateZ)
{

}

module dialogBubble_pointer()
{

}
