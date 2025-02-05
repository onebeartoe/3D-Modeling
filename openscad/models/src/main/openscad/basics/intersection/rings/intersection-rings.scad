
use <../../../shapes/open-cylinder/open-cylinder.scad>

use <../../../shapes/open-oval/open-oval.scad>

intersection()
{
    translate([-30,0,0])
    rotate([0,90,0])
    openCylinder(height = 70);

    color("green")
    translate([-20, -15,0])
    rotate([0,90,40])
    openOval(xLength = 8,
            yLength = 10,
            zLength = 50);
}
