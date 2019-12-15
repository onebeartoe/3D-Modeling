
use <../../../../shapes/open-cylinder/open-cylinder.scad>

use <../../lamp-shade.scad>

module legLampShade(outerRadius)
{
    union(outerRadius)
    {
        legLamp_shade_top();

        legLamp_shade_bottom(outerRadius);
    }
}

module legLamp_shade_bottom(outerRadius)
{
    openCylinder(height = 100,
                 outerRadius = outerRadius);
}

module legLamp_shade_top(outerRadius)
{
    translate([0, 0, 25])
    rotate([180, 0, 0])
    lampShade(outerRadius = 36,
            squareLength = 28,
            xScale = 0.3,
            yScale = 0.7);
}
