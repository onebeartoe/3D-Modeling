
module headlessTroll(stlPath, cutHeight)
{
	difference()
	{
		translate([0, 140, 0])
		originalTroll(stlPath);
//	}		
		color("green")
		translate([-20, 120, 70])
		cube([90, 110, 60]);
//		sphere(r=45);
	}
}

// Jesse Troll?
module originalTroll(stlPath)
{
	translate([-20,-40,0])
	import(stlPath);
}

module originalTrollWithBase(stlPath)
{
	union()
	{
		originalTroll(stlPath);
		
		cube([50,50,2]);
	}
}

/**
 * unionDifference: true gets union, false gets difference 
 */
module trollHead(stlPath, intersectionDifference)
{
	intersection()
	{
		color("blue")
		translate([23, 295, 130])
		sphere(r=69);
		
		color("orange")
		translate([0, 260, 0])
		originalTroll(stlPath);
	}	
}

module trollHeadFirst(stlPath, intersectionDifference)
{
	
}

module real(stlPath)
{

		
		echo("bottom");
}