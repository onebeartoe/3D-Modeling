
/**
  * Create a cylindrical cup.
  */
module cup(cupHeight=70, innerRadius=53)
{
	difference()
	{
		centered = false;
	
		// outer part of the cup
		translate([0,0,0])
		cylinder (h = cupHeight, r=55, center = centered, $fn=100);
		
		// subtracted inner cup
		translate([0,0,5])
		cylinder (h = cupHeight, r=innerRadius, center = centered, $fn=100);
	}
}