
use <../cherry-mx/blank-keycap.scad>

use <../../../../basics/rounded-edges/rounded-pyramid/rounded-pyramid.scad>

showRefereceKeycap = 1;

if(showRefereceKeycap)
{
	// this one is only for reference
	translate([90, 0, 11])
//	rotate([180,0,0])
	*blankKeycap();
}

// over lay key
translate([34, -2, 0])
*#blankKeycap();

union()
{
	legend = "3";
	xOffset = -37;
	xUppercaseOffset = xOffset - 0.5;
	font = "Arial";
	fontSize = 7.5;
	color("blue")
	translate([-3,-3.5,0])
	linear_extrude(height=4)
	text(legend, font=font, size=fontSize, center=true);
	
	color("white")
	rotate([0, 0, 45])
	roundedPyramid(h=2, r1=5, r2=3.5, cornerRadius=5, sides=20, sidesOnly=true);
}