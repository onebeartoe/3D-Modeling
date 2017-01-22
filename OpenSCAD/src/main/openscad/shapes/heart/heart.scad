
module heart(height=1)
{
    rotate ([0, 0, 45])
    linear_extrude(height=height)
    flatHeart();
}

module heartThumbnail(height=1)
{	
    xyScale = 0.725;
    translate([0, -1.5, 0])
    scale([xyScale, xyScale, 1])
    heart(height);
}

module flatHeart()
{
	square(20, center = true);
	
	translate([10,0,0])	
	circle(10, center = true, color="red" );
	
	translate([0,10,0]) 
	circle(10, center = true);
}