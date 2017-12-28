
use <../tower-segment.scad>
use <../0/tower-segment-0.scad>
//use <../1/tower-segment-1.scad>
use <../1/barad-dur-tower-segment-1.scad>
//use <../2/barad-dur-tower-segment-2.scad>

module baradDur_towerSegment_2()
{
	segment2_topRadius = baradDur_towerSegment_1_bottomRadius() + towerSegment_girthIncrement();
	segment2_bottomRadius = segment2_topRadius + towerSegment_girthIncrement();
	baradDur_towerSegment(bottomRadius = segment2_bottomRadius, topRadius = segment2_topRadius, zLength = baradDur_towerSegment_zLength());
}
