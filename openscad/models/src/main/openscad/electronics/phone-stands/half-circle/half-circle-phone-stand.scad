
use <../../../basics/rounded-edges/doughnuts/doughnuts.scad>;

module halfCirclePhoneStand()
{
    

    halfCirclePhoneStand_stand_base();
}


// sub-modules and functions follow

module halfCirclePhoneStand_stand_base()
{
    minkowskiSphereRadius = 0.5;

    color("green")
    translate([0, 0, minkowskiSphereRadius])
    roundDoughnut(height = 19.125,
                innerRadius = 4.9,
                outerRadius = 5.59,
                minkowskiSphereRadius = minkowskiSphereRadius);
}