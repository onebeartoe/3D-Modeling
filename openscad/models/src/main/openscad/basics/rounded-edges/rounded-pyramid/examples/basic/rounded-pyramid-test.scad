
use <../../rounded-pyramid.scad>

// this one has rounded a top/bottom as well as rounded sides.
color("orange")
roundedPyramid(h=5, sides=20);

// this one is shaped like a desktop keyboard keycap.
color("grey")
translate([0, 20, 0])
roundedPyramid(h=5,
	 			r1 = 7,
				r2 = 4,
				sides=20, sidesOnly=true);

// this one is shaped the keyboard keycap above but with all sides rounded
color("blue")
translate([0, 40, 0])
roundedPyramid(h=5,
				r1 = 7,
				r2 = 4,
				sides=20,
				sidesOnly=false);
