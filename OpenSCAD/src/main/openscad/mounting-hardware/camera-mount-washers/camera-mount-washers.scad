
cameraMountWasher();

module cameraMountWasher()
{
	xLength = 40;
	yLength = 60;
	
    difference()
    {
    	cube([xLength, yLength, 2]);
    	
    	translate([xLength/2.0, yLength/2.0, -0.1])
    	cylinder(r=4.5, h=2.2);
    }
}