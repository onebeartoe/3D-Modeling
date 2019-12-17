
use <../../../../shapes/open-cylinder/open-cylinder.scad>

use <../../lamp-shade.scad>

module legLampShade(bottomOuterRadius,
                    intersection_xTranslate,
                    squareLength, 
                    outerRadius,
                    xScale,
                    yScale)
{
    bottomHeight = 5;

    union(outerRadius)
    {
        translate([0, 0, bottomHeight])
        legLamp_shade_top(intersection_xTranslate = intersection_xTranslate,
                          squareLength = squareLength, 
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

    union()
    {
        openCylinder(height = height,
                    innerRadius = innerRadius,
                    outerRadius = outerRadius);

        legLamp_shade_bottom_mountingAssembly(outerHeight = height,
                         outerRadius = outerRadius);
    }
}

module legLamp_shade_bottom_mountingAssembly(outerHeight,
                                             outerRadius)
{
    innerRadius = 5;

    innerHeight = outerHeight * 3 + 1.9;

    difference()
    {
        union()
        {
            cylinder(r = innerRadius, h = innerHeight);

            legLamp_shade_bottom_mountingAssembly_stick(outerHeight = outerHeight,
                                                outerRadius = outerRadius);

            rotate([0, 0, 90])
            legLamp_shade_bottom_mountingAssembly_stick(outerHeight = outerHeight,
                                                outerRadius = outerRadius);
        }

        translate([0, 0, -0.01])
        cylinder(r = innerRadius - 2,
                 h = innerHeight + 0.02);
    }
}

module legLamp_shade_bottom_mountingAssembly_stick(outerHeight,
                         outerRadius)
{
    cube_xLength = outerRadius * 2;

    cube_yLength = 5;

    xTranslate = -cube_xLength / 2.0;

    yTranslate = -cube_yLength / 2.0;

    translate([xTranslate, yTranslate, 0])
    cube([cube_xLength, cube_yLength, outerHeight]);    
}

module legLamp_shade_top(intersection_xTranslate, squareLength, outerRadius, xScale, yScale)
{
    zTranslate = outerRadius * yScale;

    translate([0, 0, zTranslate])
    lampShade(intersection_xTranslate = intersection_xTranslate,
              outerRadius = outerRadius,
              squareLength = squareLength,
              xScale = xScale,
              yScale = yScale);
}
