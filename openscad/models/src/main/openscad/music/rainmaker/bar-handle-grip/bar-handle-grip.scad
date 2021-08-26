
use <../rainmaker.scad>


innerRadius = 12;


difference()
{

rainmaker(height = 80,
			innerRadius = innerRadius,
			outerRadius = 16,
		  	rungsPerLevel = 5,
			shellDecoration = "bumps"

// this looks good for a 3 rung rainmaker
, zRotateAngle = 5

//TODO - remove
//, zDistanceBetweenRungs = 70
			);
    
    color("blue")
    translate([0,0,4])
    cylinder(r = innerRadius, h = 182);
    
}