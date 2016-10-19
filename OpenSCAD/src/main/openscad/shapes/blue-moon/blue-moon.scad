
module blueMoon()
{
	difference() 
	{ 
		// blue moon
		cylinder (h = 4, r=10, center = true, $fn=100);
		
		// top cutout
		translate([5, 5, 0]) 
		cylinder (h = 4.20, r=6, center = true, $fn=100);
				
		// bottom cutout
		translate([5, -5, 0]) 
		cylinder (h = 4.20, r=6, center = true, $fn=100);
		
		// remainder cutout
		translate([10, 0, 5]) 
		color("red")
		cylinder (h = 14.20, r=6, center = true, $fn=100);			
	}
}

translate ([0, 12, 0])
blueMoon();
