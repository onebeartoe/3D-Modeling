
use <../../../../shapes/open-cylinder/open-cylinder.scad>

use <../../lamp-shade.scad>

outerRadius = 10;

translate([-120, 0, 0])
import("/home/roberto/Versioning/world/betoland/household/lamps/christmas-story-leg-lamp/jetpuf/files/LegLamp_Shade130.stl");

union()
{
    legLamp_shade_top();

    legLamp_shade_bottom();
}

module legLamp_shade_bottom()
{
    openCylinder(height = 100,
                 outerRadius = outerRadius);
}

module legLamp_shade_top()
{
    translate([0, 0, 25])
    rotate([180, 0, 0])
    lampShade(outerRadius = 36,
            squareLength = 28,
            xScale = 0.3,
            yScale = 0.7);
}