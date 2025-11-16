
use <../../../basics/rounded-edges/doughnuts/doughnuts.scad>

module discCoaster(cutoutAdjustment = 4,
                   drainHole = false,
                   height = 8,
                   innerRadius = 90 / 2.0)
{
    difference()
    {
//        %
        roundedDisk(fn = 25,
                    height = height,
                    minkowskiSphereRadius = 2,
                    radius = 95 / 2.0);

        color("green")
        translate([0,0,cutoutAdjustment])
        cylinder (h = 24, 
                    r= innerRadius, 
                    // center = true, 
                    $fn=50);
    }
}
