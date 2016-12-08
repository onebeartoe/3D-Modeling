
module heart(h=1)
{
    rotate ([0, 0, 45])
    linear_extrude(height=h)
    flatHeart();
}

module heartThumbnail()
{	
	xyScale = 0.725;
	translate([0, -1.5, 0])
	scale([xyScale, xyScale, 1])
	heart();
}

module flatHeart()
{
	square(20, center = true);
	
	translate([10,0,0])	
	circle(10, center = true, color="red" );
	
	translate([0,10,0]) 
	circle(10, center = true);
}