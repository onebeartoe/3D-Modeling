
use <../../../../../../shapes/geometry/arc/extruded/extruded-arc.scad>

use <../../../../../../basics/rounded-edges/doughnuts/doughnuts.scad>

module endCap()
{
    arcRadius = 20;

    union()
    {
        translate([0, 0, -1])
        rotate([0, 0, 90])
        roundedRectangularArc(angle = 170,
                            height = 10,
                            radius = arcRadius, 
                            radiusExtension = 2,
                            minkowskiFn = 10,
                            minkowskiRadius = 1);

        pegAttachements(arcRadius = arcRadius);
    }
}

module pegAttachements(arcRadius)
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

