
module baradDur_towerSegment(topRadius, zLength)
{
	bottomRadius = topRadius + 3;
    cylinder(h=zLength, r1=bottomRadius, r2=topRadius, $fn=40);
}
