
use <../../../basics/rounded-edges/doughnuts/doughnuts.scad>;

use <../../../shapes/geometry/arc/extruded/extruded-arc.scad>;

module halfCirclePhoneStand(height = 19.125,
                            minkowskiSphereRadius = 0.5)
{
    halfCirclePhoneStand_cradle(height = height,
                                minkowskiSphereRadius = minkowskiSphereRadius);

    halfCirclePhoneStand_stand(height = height,
                               minkowskiSphereRadius = minkowskiSphereRadius);
}

// sub-modules and functions follow

module halfCirclePhoneStand_cradle(height,
                                   minkowskiSphereRadius)
{
    xTranslate = 30;      // 29.9
    yTranslate = 32.7;      // 32.6
    zTranslate = minkowskiSphereRadius + 0;     // 0.13;
    color("magenta")
    translate([xTranslate, yTranslate, zTranslate])
    rotate([0, 0, 213])     // 212
    roundedRectangularArc(angle = 150,

//TODO: fix/remove the height adjustment
height = height,
                          minkowskiRadius = minkowskiSphereRadius,
                          radius = 36,   // 36
                          radiusExtension = 1.5);   // 1.3
}

module halfCirclePhoneStand_stand(height,
                                  minkowskiSphereRadius)
{
    halfCirclePhoneStand_stand_top(height = height,
                                   minkowskiSphereRadius = minkowskiSphereRadius);

    halfCirclePhoneStand_stand_base(height = height,
                                    minkowskiSphereRadius = minkowskiSphereRadius);
}

module halfCirclePhoneStand_stand_base(height,
                                       minkowskiSphereRadius)
{
    color("green")
    translate([0, 0, minkowskiSphereRadius])
    roundDoughnut(height = height,
                innerRadius = 4.9,      // 4.9
                outerRadius = 5.59,     // 5.59
                minkowskiSphereRadius = minkowskiSphereRadius);
}

module halfCirclePhoneStand_stand_top(height,
                                      minkowskiSphereRadius)
{
    xTranslate = 8.105;  // 8.05     // 8.1
    yTranslate = 8.85;  // 8.85     // 8.9

    color("green")
    translate([xTranslate, yTranslate, minkowskiSphereRadius])
    roundDoughnut(height = height,
                innerRadius = 1.9,  // 2.0
                outerRadius = 2.6,  // 2.6
                minkowskiSphereRadius = minkowskiSphereRadius);
}



