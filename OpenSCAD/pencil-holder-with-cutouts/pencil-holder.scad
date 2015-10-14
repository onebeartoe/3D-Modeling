
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
	
	
// was from spur-vase-sprial-lucky-charms.scad	
    // vase
//    difference()
//    {
//        // outer vase
//        translate([0,0,0])
//        cylinder (h = vaseHeight, r=55, $fn=100);
        
//        // remvoed inner vase centered
//        translate([0,0,5])
//        cylinder (h = vaseHeight, r=54, $fn=100);
//    }	
	
}