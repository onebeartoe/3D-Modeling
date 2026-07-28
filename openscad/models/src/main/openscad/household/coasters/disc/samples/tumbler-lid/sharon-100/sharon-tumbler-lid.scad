
use <../../../disc-coaster.scad>

radius = 101 / 2.0;

difference()
{
    discCoaster(innerRadius = radius);

    translate([radius - 15, 0, -0.01])
    cylinder(r = 8 / 2.0, h = 30);
}
