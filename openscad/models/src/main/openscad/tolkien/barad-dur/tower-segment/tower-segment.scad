
module baradDur_towerSegment(bottomRadius, topRadius, zLength)
{
	difference()
	{
    	cylinder(h=zLength, r1=bottomRadius, r2=topRadius, $fn=40);

		translate([0, 0, -0.01])
		cylinder(r=topRadius - 10, h=zLength + 0.02);//, center=true);
	}
}

function towerSegment_girthIncrement() = 2.5;
