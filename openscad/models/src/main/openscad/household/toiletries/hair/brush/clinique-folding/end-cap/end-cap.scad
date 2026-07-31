
use <../../../../../../shapes/geometry/arc/extruded/extruded-arc.scad>

use <../../../../../../basics/rounded-edges/doughnuts/doughnuts.scad>

module endCap(showBristlesAttachment = false)
{
    arcHeight = 8;
    arcRadius = 14.0;

    union()
    {
        endCapArc(arcHeight = arcHeight,
                  arcRadius = arcRadius);

       pegAttachments(arcRadius = arcRadius,
                      arcHeight = arcHeight);
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

    xTranslate = arcRadius + (outerRadius / 2.0);
    yTranslate = 0;
    zTranslate = outerRadius;

    translate([xTranslate, yTranslate, zTranslate])
    onePegAttachment(outerRadius = outerRadius);

    translate([-xTranslate, yTranslate, zTranslate])
    onePegAttachment(outerRadius = outerRadius);
}

module onePegAttachment(outerRadius)
{
    minkowskiSphereRadius = 0.0;

//TODO:???? Might have to use a RoundedCube or an openCylinder 
//TODO:????      if the arc part is too thing for this radius  
    color("orange")
    rotate([90, 0, 0])
    roundDoughnut(height = 19,
                innerRadius = 2.6,
                outerRadius = outerRadius,
                minkowskiSphereRadius = minkowskiSphereRadius);
}
