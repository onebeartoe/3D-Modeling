
use <../heart/heart.scad>;

module clover(sideHeartRotation = 100)
{
	union () 
	{ 
		rotate ([0, 0, sideHeartRotation])
		translate ([0,14,0])
		heart();
		
		rotate ([0, 0, 0])
		translate ([0,14,0])
		heart();
		
		rotate ([0, 0, -sideHeartRotation])
		translate ([0, 14, 0])
		heart();
		
//		color ("red")
		translate([-3.5,-30,0])
		cube (size = [7, 40, 15]);
	}
}

clover();
