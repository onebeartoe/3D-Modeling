
use <../cone.scad>

cone(height = 20, bottomRadius = 20, topRadius = 10);

translate([50, 0, 0])
cone(height = 20, bottomRadius = 10, topRadius = 20);
