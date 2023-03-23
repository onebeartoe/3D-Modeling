
use <../../../basics/rounded-edges/doughnuts/doughnuts.scad>

module eggHolder()
{
    chickenFoot();
}

module chickenFoot()
{
    union()
    {
        chickenFoot_toe();
    }
}

module chickenFoot_toe(height,
                        minkowskiSphereRadius)
{
    translate([0,height/2.0, 0])
    rotate([90, 0, 0])
    roundedDisk(height = height,
                        minkowskiSphereRadius = minkowskiSphereRadius);
}
