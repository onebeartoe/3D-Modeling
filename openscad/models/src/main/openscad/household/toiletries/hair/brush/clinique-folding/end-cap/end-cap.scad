
use <../../../../../../shapes/geometry/arc/extruded/extruded-arc.scad>

use <../../../../../../basics/rounded-edges/rounded-cube/rounded-cube.scad>

module endCap(showBristlesAttachment = false)
{
    arcHeight = 8;
    arcRadius = 14.0;

    difference()
    {
        endCapArc(arcHeight = arcHeight,
                  arcRadius = arcRadius);

        cutoutHeight = 19;
        cutoutRadius = 2.35;
        xTranslate = arcRadius + ( (arcHeight+1) / 2.0) - (cutoutRadius/2.0) - 0.35;
        yTranslate = 8.0; // the length of the peg sticking out of the bristle attachment
        zTranslate = (arcHeight / 2.0);// + cutoutRadius;
        translate([xTranslate, yTranslate, zTranslate])
        rotate([90, 0, 0])
        cylinder(h = cutoutHeight,
                 r = cutoutRadius,
                 $fn = 30);

        translate([-xTranslate, yTranslate, zTranslate])
        rotate([90, 0, 0])
        cylinder(h = cutoutHeight,
                 r = cutoutRadius,
                 $fn = 30);                
    }

    if(showBristlesAttachment)
    {
        xLength = 41;
        yLength = 70;
        
        #
        color("green")
        translate([-xLength/2.0, -yLength, 0])
        cube([xLength, yLength, arcHeight], center = false);
    }
}

module endCapArc(arcHeight, arcRadius)
{
    minkowskiRadius = 1;

    height = arcHeight - (minkowskiRadius * 2);

    color("red")
    translate([0, 0, minkowskiRadius])
    rotate([0, 0, 90])
    roundedRectangularArc(angle = 177.0,
                        height = height,
                        radius = arcRadius, 
                        radiusExtension = (arcHeight + 4) / 2.0,
                        minkowskiFn = 10,
                        minkowskiRadius = minkowskiRadius);
}
