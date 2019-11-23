
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
    zTranslate = minkowskiSphereRadius + 0;     // 0.13;
    color("pink")
    translate([28.2, 31.2, zTranslate])
    rotate([0, 0, 211])
    roundedRectangularArc(angle = 156,

//TODO: fix/remove the height adjustment
height = height,
                          minkowskiRadius = minkowskiSphereRadius,
                          radius = 34.89,
                          radiusExtension = 0.8);
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
