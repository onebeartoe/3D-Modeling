
difference()
{
	cylinder (h = 2, r=55, center = true, $fn=100);

	translate([0,0,-5])
	scale([0.5, 0.5, 13.9])
	import("spurs-a.stl");
}