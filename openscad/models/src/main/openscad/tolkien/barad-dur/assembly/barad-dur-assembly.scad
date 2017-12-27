
use <../tower-segment/tower-segment.scad>
use <../tower-segment/0/tower-segment-0.scad>

use <../window-of-the-eye/window-of-the-eye.scad>

module baradDurAssembly()
{
	topRadius = 30;

	towerSegment_zLength = 50;

	baradDurAssembly_top(towerSegments_zLength = towerSegment_zLength);

	// tower segment 0
	segment2_topRadius = 30;
	segment2_bottomRadius = segment2_topRadius + towerSegment_girthIncrement();
	translate([0, 0, towerSegment_zLength * 2])
	baradDur_towerSegment(bottomRadius = segment2_bottomRadius, topRadius = segment2_topRadius, zLength=towerSegment_zLength);

	// tower segment 1
	segment1_topRadius = segment2_bottomRadius + towerSegment_girthIncrement();
	segment1_bottomRadius = segment1_topRadius + towerSegment_girthIncrement();
	translate([0, 0, towerSegment_zLength])
	baradDur_towerSegment(bottomRadius = segment1_bottomRadius, topRadius = segment1_topRadius , zLength=towerSegment_zLength);

	// tower segment 2 - bottom most tower segment
	segment0_topRadius = segment1_bottomRadius + towerSegment_girthIncrement();
	segment0_bottomRadius = segment0_topRadius + towerSegment_girthIncrement();
	baradDur_towerSegment(bottomRadius = segment0_bottomRadius, topRadius = segment0_topRadius, zLength = towerSegment_zLength);
}

/** Support functions and modules follow. **/

module baradDurAssembly_top(towerSegments_zLength)
{
	xTranslate = 0;
	yTranslate = -0;
	zTranslate = (towerSegments_zLength * 3) + 33;

	color("red")
	translate([xTranslate, yTranslate, zTranslate])
	rotate([0, -90, 90])
	windowOfTheEye();
}
