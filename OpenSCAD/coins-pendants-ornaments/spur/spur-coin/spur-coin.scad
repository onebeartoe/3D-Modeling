
module spurCoin(height=4,
                radius=15,
                xScale=0.13,
                yScale=0.13)
{
	difference()
	{
		cylinder (h = height, r=radius, center = true, $fn=100);
	
		translate([0,0,-5])
		scale([xScale, yScale, 13.9])
		import("spurs-a.stl");
	}
}