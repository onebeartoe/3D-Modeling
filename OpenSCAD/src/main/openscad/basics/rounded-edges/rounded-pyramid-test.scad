
use <rounded-pyramid.scad>

// this one is shaped like a desktop keyboard keycap.
color("grey")
translate([0, 130, 0])
roundedPyramid(5, sides=20, sidesOnly=true);

// this one has rounded a top/bottom as well as rounded sides.
color("orange")
roundedPyramid(5, sides=20);
