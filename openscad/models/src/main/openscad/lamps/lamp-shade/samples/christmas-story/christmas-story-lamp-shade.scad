
use <../../../../shapes/open-cylinder/open-cylinder.scad>

use <../../lamp-shade.scad>

module legLampShade(bottomOuterRadius,
                    squareLength, 
                    outerRadius,
                    xScale,
                    yScale)
{
    bottomHeight = 5;

    union(outerRadius)
    {
        translate([0, 0, bottomHeight])
        legLamp_shade_top(squareLength = squareLength, 
                          outerRadius = outerRadius,
                          xScale = xScale,
                          yScale = yScale);

        color("purple")
        legLamp_shade_bottom(height = bottomHeight, 
                             outerRadius = bottomOuterRadius);
    }
}

module legLamp_shade_bottom(height, outerRadius)
{
    innerRadius = outerRadius - 2.0;

    openCylinder(height = height,
                 innerRadius = innerRadius,
                 outerRadius = outerRadius);
}

module legLamp_shade_top(squareLength, outerRadius, xScale, yScale)
{
    zTranslate = outerRadius * yScale;

    translate([0, 0, zTranslate])
    lampShade(outerRadius = outerRadius,
            squareLength = squareLength,
            xScale = xScale,
            yScale = yScale);
}
