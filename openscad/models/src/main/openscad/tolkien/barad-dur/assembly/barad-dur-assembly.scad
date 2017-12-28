
use <../tower-segment/tower-segment.scad>
use <../tower-segment/0/tower-segment-0.scad>
use <../tower-segment/1/barad-dur-tower-segment-1.scad>
use <../tower-segment/2/barad-dur-tower-segment-2.scad>

use <../window-of-the-eye/window-of-the-eye.scad>

module baradDurAssembly()
{
	baradDurAssembly_top(towerSegments_zLength = baradDur_towerSegment_zLength());

	// tower segment 0
	translate([0, 0, baradDur_towerSegment_zLength() * 2])
	rotate([0,0,-90])
	baradDur_towerSegment_0(brackets=true);

	// tower segment 1
	translate([0, 0, baradDur_towerSegment_zLength()])
	baradDur_towerSegment_1();

	// tower segment 2 - bottom most tower segment
	baradDur_towerSegment_2();
}

/** Support functions and modules follow. **/

module baradDurAssembly_top(towerSegments_zLength)
{
	xTranslate = 0;
	yTranslate = 7;
	zTranslate = (towerSegments_zLength * 3) + 27.5;

	color("red")
	translate([xTranslate, yTranslate, zTranslate])
	rotate([0, -90, 90])
	windowOfTheEye();
}
