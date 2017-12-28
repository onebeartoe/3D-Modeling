
use <../tower-segment/tower-segment.scad>
use <../tower-segment/0/tower-segment-0.scad>
use <../tower-segment/1/barad-dur-tower-segment-1.scad>

use <../window-of-the-eye/window-of-the-eye.scad>

module baradDurAssembly()
{
	baradDurAssembly_top(towerSegments_zLength = baradDur_towerSegment_zLength());

	// tower segment 0
//	segment0_topRadius = baradDur_towerSegment_0_topRadius();
//	segment0_bottomRadius = baradDur_towerSegment_0_bottomRadius();
	translate([0, 0, baradDur_towerSegment_zLength() * 2])
	rotate([0,0,-90])
	baradDur_towerSegment_0(brackets=true);

	// tower segment 1
//	color("magenta")
	translate([0, 0, baradDur_towerSegment_zLength()])
	baradDur_towerSegment_1();

	// tower segment 2 - bottom most tower segment
	segment2_topRadius = baradDur_towerSegment_1_bottomRadius() + towerSegment_girthIncrement();
	segment2_bottomRadius = segment2_topRadius + towerSegment_girthIncrement();
	baradDur_towerSegment(bottomRadius = segment2_bottomRadius, topRadius = segment2_topRadius, zLength = baradDur_towerSegment_zLength());
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
