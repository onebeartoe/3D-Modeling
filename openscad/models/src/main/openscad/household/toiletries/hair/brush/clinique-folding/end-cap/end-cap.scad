
use <../../../../../../shapes/geometry/arc/extruded/extruded-arc.scad>

use <../../../../../../basics/rounded-edges/doughnuts/doughnuts.scad>

module endCap(showBristlesAttachment = false)
{
    arcHeight = 8;
    arcRadius = 20;

    union()
    {
        translate([0, 0, 0])
        rotate([0, 0, 90])
        roundedRectangularArc(angle = 170,
                            height = arcHeight,
                            radius = arcRadius, 
                            radiusExtension = 2,
                            minkowskiFn = 10,
                            minkowskiRadius = 1);

        pegAttachments(arcRadius = arcRadius,
                        arcHeight = arcHeight);
    }

    if(showBristlesAttachment)
    {
        xLength = 41;
        yLength = 70;

        color("green")
        translate([-xLength/2.0, -yLength, 0])
        cube([xLength, yLength, arcHeight], center = false);
    }
}

module endCapArc(arcHeight, arcRadius)
{
    
}

module pegAttachments(arcHeight, arcRadius)
{
    xTranslate = 30;

    translate([arcRadius, 0, 0])
    onePegAttachement();

    translate([-arcRadius, 0, 0])
    onePegAttachement();
}

module onePegAttachement()
{
    minkowskiSphereRadius = 0.5;
    outerRadius = 3.5;

// Might have to use a RoundedCube or an openCylinder 
//      if the arc part is too thing for this raduis  
    color("orange")
    translate([0, 0, outerRadius])
    rotate([90, 0, 0])
    roundDoughnut(height = 19,
                innerRadius = 2.6,
                outerRadius = outerRadius,
                minkowskiSphereRadius = minkowskiSphereRadius);
}

