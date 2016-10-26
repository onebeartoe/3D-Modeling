
laserCylinderCutoutRadius = 3.6;
laserTubeLength = 10;

laserMount();

module laserMount()
{
	difference()
	{
		laserTube();
		
		laserCutout();
	}
}

/**
 * This is the space for the laser that is cut out of laserTube().
 */
module laserCutout()
{
	union()
	{
		height = laserTubeLength + 0.02;
		translate([0,0,-0.01])
		cylinder(h=height, r=laserCylinderCutoutRadius, $fn=30);
	
		cubeHeight = height / 2.0;
		translateZ = cubeHeight / 2.0 - 0.01;
		cubeX = 9;
		color("green")
		translate([0,0,translateZ])
		cube([cubeX, 2, cubeHeight], center=true);
	}
}

/**
 * This is the tube that holds the laser module.
 */
module laserTube()
{
	height = laserTubeLength;
	radius = laserCylinderCutoutRadius + 1.5;
	cylinder(h=height, r=radius, $fn=30);
}
