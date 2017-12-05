
use <MCAD/triangles.scad>
//use <MCAD/shapes.scad>

use <../open-oval/open-oval.scad>

module dialogBubble(pointerRotateZ = 25,
					yLength = 10)
{
	difference()
	{
		dialogBubble_block(pointerRotateZ, yLength);

		dialogBubble_cutouts(pointerRotateZ, yLength);
	}

//	dialogBubble_cutouts(pointerRotateZ, yLength);
}

/** Support functions and modules follow.  **/

module dialogBubble_block(pointerRotateZ, yLength)
{
	union()
	{
//		% // transparent
		openOval(borderThickness = 1.5,
				 yLength = yLength);

		dialogBubble_pointer(pointerRotateZ, yLength);
	}
}

module dialogBubble_cutouts(pointerRotateZ, yLength)
{

	translate([-3.1, 3.5, -0.02])
	scale([1,1,1.02])
	dialogBubble_pointer(pointerRotateZ, yLength);
}

module dialogBubble_pointer(pointerRotateZ, yLength)
{
	yTranslate = -5;
	yTranslate = -yLength + 5;
	rotateZ = pointerRotateZ;
	translate([15, yTranslate, 0])
	rotate([0, 0, rotateZ])
	triangle(o_len = -8, a_len = -5, depth=5);
}
