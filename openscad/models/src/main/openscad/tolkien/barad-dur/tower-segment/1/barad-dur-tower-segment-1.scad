
use <../tower-segment.scad>

use <../0/tower-segment-0.scad>

module baradDur_towerSegment_1()
{
	segment1_topRadius = baradDur_towerSegment_1_topRadius();
	segment1_bottomRadius = segment1_topRadius + towerSegment_girthIncrement();
	baradDur_towerSegment(bottomRadius = segment1_bottomRadius, topRadius = segment1_topRadius , zLength=baradDur_towerSegment_zLength());
}

/** Support functions and modules follow. **/

function baradDur_towerSegment_1_topRadius() = baradDur_towerSegment_0_bottomRadius() + towerSegment_girthIncrement();

function baradDur_towerSegment_1_bottomRadius() = baradDur_towerSegment_1_topRadius() + towerSegment_girthIncrement();
