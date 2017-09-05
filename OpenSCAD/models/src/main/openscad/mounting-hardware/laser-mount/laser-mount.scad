
laserCylinderCutoutRadius = 3.5;
laserTubeLength = 25;

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
	
		// this is the rectangular cut out for the laser's PCB 
		cubeHeight = height - 10.0;
		translateZ = cubeHeight / 2.0 - 0.01;
		
		cubeSizeX = 8.25; // this is how deep the rectangle cutout goes into the laster tube
		cubeTranslateY = 1;
		
		color("green")
		translate([0,cubeTranslateY,translateZ])
		cube([cubeSizeX, 2, cubeHeight], center=true);
	}
}

/**
 * This is the tube that holds the laser module.
 */
module laserTube()
{
	height = laserTubeLength;
	radius = laserCylinderCutoutRadius + 2.50;
	cylinder(h=height, r=radius, $fn=30);
}
