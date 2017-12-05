
use <../dialog-bubble.scad>

module stencilDialogBubble()
{
	difference()
	{
		yLength = 15;

		dialogBubble(yLength = yLength);

		stencilDialogBubble_lines(yLength);
	}
}

module stenciledDialogBubbleThumbnail()
{
	xyScale = 0.62134;
	scale([xyScale, xyScale, 1])
	stencilDialogBubble();
}

/** Support functions and modules follow. **/

module stencilDialogBubble_lines(yLength)
{
	xLength = 100;
	xTranslate = -yLength - 15;
	translate([xTranslate, 0, -0.2])
	scale([1,1,2])
	union()
	{
		// horizontal 0
		translate([0,10,0])
		cube([xLength, 1, 1]);

		// horizontal 1
		cube([xLength, 1, 1]);

		// horizontal 2
		translate([0,-10,0])
		cube([xLength, 1, 1]);
	}
}
