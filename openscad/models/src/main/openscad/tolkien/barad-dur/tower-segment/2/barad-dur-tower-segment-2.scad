
use <../tower-segment.scad>
use <../0/tower-segment-0.scad>
use <../1/barad-dur-tower-segment-1.scad>

module baradDur_towerSegment_2()
{
	segment2_topRadius = baradDur_towerSegment_2_topRadius();
	segment2_bottomRadius = baradDur_towerSegment_2_bottomRadius();

	baradDur_towerSegment(bottomRadius = segment2_bottomRadius,
						  electronicsCutouts = true,
						  topRadius = segment2_topRadius,
						  zLength = baradDur_towerSegment_zLength());
}

/** Support functions and modules follow **/

function baradDur_towerSegment_2_topRadius() =  baradDur_towerSegment_1_bottomRadius() + towerSegment_girthIncrement();

function baradDur_towerSegment_2_bottomRadius() = baradDur_towerSegment_2_topRadius() + towerSegment_girthIncrement();
