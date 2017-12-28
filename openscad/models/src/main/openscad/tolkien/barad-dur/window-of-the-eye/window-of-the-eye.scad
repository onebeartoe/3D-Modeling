
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

			windowOfTheEye_attachmentNubs();
		}

		translate([0, 0, -0.01])
		scale([1,1,1.01])
		uncannyEyes_lcdTop();
	}
}

/** Support functions and modules follow. **/

function windowOfTheEye_attachmentNub_xLength() = 3.5;

function windowOfTheEye_attachmentNub_yLength() = windowOfTheEye_attachmentNub_xLength();

module windowOfTheEye_attachmentNubs()
{
	// the attachment nub
	xLength = windowOfTheEye_attachmentNub_xLength();
	yLength = windowOfTheEye_attachmentNub_yLength();
	zLength = 5;
	xTranslate = -27.5;
	yTranslate = windowOfTheEye_spires_yLength() / 2 - yLength;
	zTranslate = 6;
	color("green")
	translate([xTranslate, yTranslate, zTranslate])
	cube([xLength, yLength, zLength]);

	nub2_yTranslate = -yTranslate - yLength;
	color("green")
	translate([xTranslate, nub2_yTranslate, zTranslate])
	cube([xLength, yLength, zLength]);
}

function windowOfTheEye_spires_xLength() = 69;

function windowOfTheEye_spires_yLength() = 57;

module windowOfTheEye_spires()
{
	difference()
	{
		xLength = windowOfTheEye_spires_xLength();
		yLength = 57;
		xTranslate = 7;
		translate([xTranslate, 0, 3])
		cube([xLength, yLength, 6], center=true);

		windowOfTheEye_spiresOvalCutout(cubeXLength = xLength);

		windowOfTheEye_spiresStraglerCutout(xLength = xLength,
											yLength = yLength,
											xTranslate = xTranslate);
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

//TODO: Do the paramters need to change to local variables set by calls support functions?
module windowOfTheEye_spiresStraglerCutout(xLength, yLength, xTranslate)
{
	// stragler cutout
	translate([xTranslate-1,0,0])
	cube([xLength-9, yLength-9, 16], center=true);
}
