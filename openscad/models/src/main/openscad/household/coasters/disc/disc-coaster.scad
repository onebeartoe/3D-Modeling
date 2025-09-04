
use <../../../basics/rounded-edges/doughnuts/doughnuts.scad>

module discCoaster()
{
    difference()
    {
//        %
        roundedDisk(fn = 25,
                    height = 8,
                    minkowskiSphereRadius = 2,
                    radius = 95 / 2.0);

        color("green")
        translate([0,0,4])
        cylinder (h = 24, 
                    r=90 / 2.0, 
                    // center = true, 
                    $fn=50);
    }
}
