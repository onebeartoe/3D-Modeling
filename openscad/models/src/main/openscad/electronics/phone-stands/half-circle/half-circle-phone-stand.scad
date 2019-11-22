
use <../../../basics/rounded-edges/doughnuts/doughnuts.scad>;

module halfCirclePhoneStand(minkowskiSphereRadius = 0.5)
{
    

    halfCirclePhoneStand_stand_base(minkowskiSphereRadius = minkowskiSphereRadius);
}


// sub-modules and functions follow

module halfCirclePhoneStand_stand_base(minkowskiSphereRadius)
{
    color("green")
    translate([0, 0, minkowskiSphereRadius])
    roundDoughnut(height = 19.125,
                innerRadius = 4.9,
                outerRadius = 5.59,
                minkowskiSphereRadius = minkowskiSphereRadius);
}