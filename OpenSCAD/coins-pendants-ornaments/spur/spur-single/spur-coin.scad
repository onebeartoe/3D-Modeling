
module spurCoin()
{
	difference()
	{
		cylinder (h = 4, r=15, center = true, $fn=100);
	
		translate([0,0,-5])
		scale([0.13, 0.13, 13.9])
		import("spurs-a.stl");
	}
}