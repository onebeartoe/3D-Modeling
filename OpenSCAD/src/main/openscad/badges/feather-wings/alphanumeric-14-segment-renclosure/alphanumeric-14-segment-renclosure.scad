
/**
 * This model is inspired by this print for LED knuckles by Adafruit
 * 
 *      http://www.thingiverse.com/thing:372777
 * 
 */

use <../../../basics/rounded-cube.scad>

alphanumeric14SegmentEnclosure();

module alphanumeric14SegmentEnclosure()
{
//	boardLength = 150;
//	boardWidth = 100;

	outerSize = [51, 32.6, 20];
	
	innerSize = [44, 25, 40];
	
	difference()
	{
		roundedCube(outerSize, 5, sides = 20, , sidesOnly=true);
		
		translate([5,5,-10])
		roundedCube(innerSize, 5, sides = 20, , sidesOnly=true);		
	}
	
}
