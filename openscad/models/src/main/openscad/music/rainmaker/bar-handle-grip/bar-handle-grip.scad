
use <../rainmaker.scad>


// innerRadius = 11.0;
innerRadius = 11.25;
// innerRadius = 11.5;

outerRadius = innerRadius + 4;

difference()
{

rainmaker(height = 80,
			innerRadius = innerRadius,
			outerRadius = outerRadius,
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