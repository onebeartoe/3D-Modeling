
use <alphanumeric-14-segment-renclosure.scad>

adafruitModel();

alphanumeric14SegmentEnclosure();

module adafruitModel()
{
	stl = "C:/home/owner/versioning/github/3D-Modeling/OpenSCAD/external-resources/adafruit/led-knuckles/knuckleBox.stl";
	
	color("blue")
	translate([-30,-190,0])
	import(stl);	
}
