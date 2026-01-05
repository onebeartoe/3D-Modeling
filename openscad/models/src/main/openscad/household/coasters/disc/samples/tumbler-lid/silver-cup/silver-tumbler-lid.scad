
use <../../../disc-coaster.scad>


radius = 87 / 2.0;
//radius = 88 / 2.0;  // slightly big

difference()
{
    discCoaster(innerRadius = radius);

    translate([radius - 15, 0, -0.01])
    cylinder(r = 8 / 2.0, h = 30);
}
