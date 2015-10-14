
// RENAME THIS FILE TO shapes/cup.scad

module cup(vaseHeight=70)
{
	difference()
	{
		centered = false;
	
		// outer vase
		translate([0,0,0])
		cylinder (h = vaseHeight, r=55, center = centered, $fn=100);
		
		// remvoed inner vasecentered spur
		translate([0,0,5])
		cylinder (h = vaseHeight, r=53, center = centered, $fn=100);
	}
}