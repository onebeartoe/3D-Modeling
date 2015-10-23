use <../horseshoe/horseshoe.scad>;

module bar()
{
	translate ([-30, 43, 0]) 
	color ("black")
	linear_extrude(height=1)
	square ([60 , 6]);
}

module hourglass()
{
	union () 
	{ 
		// top bar
		bar();
		
		// top glass
		rotate ([0, 0, 180]) 
		translate ([0, -43, 0])
		color("teal")
		linear_extrude(height=1)
		horseshoeProjection();

		// botton glass
		translate ([0, -43, 0])
		linear_extrude(height=1)
		horseshoeProjection();
		
		// bottom bar
		translate ([0, -92, 0]) 
		bar();
	}
}

translate ([0, 49, 0])
hourglass();