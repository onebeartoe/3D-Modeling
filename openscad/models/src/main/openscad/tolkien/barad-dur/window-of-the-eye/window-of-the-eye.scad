
use <../../../external-resources/adafruit/uncanny-eyes/LCD_Top.scad>
use <../../../shapes/oval/oval.scad>

module windowOfTheEye()
{
//	union()
	difference()
	{
		union()
		{
			color("red")
			windowOfTheEye_spires();

			// the attachment nub
			xLength = windowOfTheEye_attachmentNub_xLength();
			yLength = windowOfTheEye_attachmentNub_yLength();
			color("green")
			translate([-27.5, 0, 6])
			cube([xLength, yLength, 5]);
		}

		translate([0, 0, -0.01])
		scale([1,1,1.01])
		uncannyEyes_lcdTop();
	}
}

/** Support functions and modules follow. **/

function windowOfTheEye_attachmentNub_xLength() = 3.5;

function windowOfTheEye_attachmentNub_yLength() = 4;

module windowOfTheEye_spires()
{
	difference()
	{
		xLength = 69;
		yLength = 57;
		xTranslate = 7;
		translate([xTranslate, 0, 3])
		cube([xLength, yLength, 6], center=true);

		windowOfTheEye_spiresOvalCutout(cubeXLength = xLength);

		// stragler cutout
		translate([xTranslate-1,0,0])
		cube([xLength-9, yLength-9, 16], center=true);
	}
}

module windowOfTheEye_spiresOvalCutout(cubeXLength)
{
	xTranslate = cubeXLength / 2.0;
	translate([xTranslate, 0, -0.01])
	oval(height = 6.02,
		 radius = 22.5,
		 xScale = 1.8,
		 yScale = 1.2);
}
