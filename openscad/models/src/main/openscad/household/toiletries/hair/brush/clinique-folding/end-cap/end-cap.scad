
use <../../../../../../shapes/geometry/arc/extruded/extruded-arc.scad>

use <../../../../../../basics/rounded-edges/rounded-cube/rounded-cube.scad>

module endCap(showBristlesAttachment = false)
{
    arcHeight = 8;
    arcRadius = 14.0;

    difference()
    {
        union()
        {
            endCapArc(arcHeight = arcHeight,
                    arcRadius = arcRadius);

            pegAttachments(arcRadius = arcRadius,
                        arcHeight = arcHeight);
        }

        cutoutHeight = 19;
        cutoutRadius = 2.6;
        xTranslate = arcRadius + cutoutRadius;
        yTranslate = 8; // the length of the peg sticking out of the bristle attachment
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
    roundedRectangularArc(angle = 175,
                        height = height,
                        radius = arcRadius, 
                        radiusExtension = (arcHeight + 4) / 2.0,
                        minkowskiFn = 10,
                        minkowskiRadius = minkowskiRadius);
}

module pegAttachments(arcHeight, arcRadius)
{
    outerRadius = arcHeight / 2.0;

    xTranslate = arcRadius + (outerRadius / 2.0) + 0.75;
    yTranslate = 4;
    zTranslate = outerRadius;

    translate([xTranslate, yTranslate, zTranslate])
    onePegAttachment(outerRadius = outerRadius);

    translate([-xTranslate, yTranslate, zTranslate])
    onePegAttachment(outerRadius = outerRadius);
}

module onePegAttachment(outerRadius)
{
    minkowskiSphereRadius = 0.0;

    cornerRadius = 1;
    xLength = (outerRadius - cornerRadius) * 2.0;
    yLength = 7;
    size = [xLength, yLength, xLength];
    xTranslate = -xLength / 2.0;
    zTranslate = -xLength / 2.0;

    color("blue")
    translate([xTranslate, -yLength, zTranslate])
    roundedCube(cornerRadius = cornerRadius,
                sides=20,
                size=size);    
}
