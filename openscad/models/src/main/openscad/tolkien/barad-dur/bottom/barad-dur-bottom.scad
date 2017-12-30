
use <../tower-segment/2/barad-dur-tower-segment-2.scad>

module baradDurBottom()
{
	radius = baradDur_towerSegment_2_bottomRadius();
	cylinder(r=10, h=1.2, center=true);
}
