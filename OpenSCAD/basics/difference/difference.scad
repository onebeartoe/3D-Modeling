
use <../../shapes/cup/cup.scad>;

difference()
{
	import("shark_cubical_name_plate.stl");

	translate([0,0,-2.1])
	cube (//center=true, 
		  size = [60, 40, 15]);
}

translate([5,5,5])
cube (//center=true, 
          size = [60, 40, 15]);