
use <../../../../shapes/open-cylinder/open-cylinder.scad>

use <../../lamp-shade.scad>

module legLampShade(squareLength, outerRadius)
{
    bottomHeight = 5;

    union(outerRadius)
    {
        translate([0, 0, bottomHeight])
        legLamp_shade_top(squareLength = squareLength, outerRadius = outerRadius);

        color("purple")
        legLamp_shade_bottom(height = bottomHeight, outerRadius = outerRadius * 2);
    }
}

module legLamp_shade_bottom(height, outerRadius)
{
    innerRadius = outerRadius - 1;

    openCylinder(height = height,
                 innerRadius = innerRadius,
                 outerRadius = outerRadius);
}

module legLamp_shade_top(squareLength, outerRadius)
{
    zTranslate = outerRadius * 0.7;   // 2.0 ;// + ( 10 / 2.0 );

    translate([0, 0, zTranslate])
    lampShade(outerRadius = outerRadius,
            squareLength = squareLength,
            xScale = 0.3,
            yScale = 0.7);
}
