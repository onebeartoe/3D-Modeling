
translate ([0, 14, 0])
heart();

module heart()
{
    rotate ([0, 0, 45])
    linear_extrude(height=10)
    flatHeart();
}

module flatHeart()
{
	square(20, center = true);
	
	translate([10,0,0])	
	circle(10, center = true, color="red" );
	
	translate([0,10,0]) 
	circle(10, center = true);
}