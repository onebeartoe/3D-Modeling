
use <../../../basics/rounded-edges/doughnuts/doughnuts.scad>

module discCoaster(cutoutAdjustment = 4,
                   drainHole = false,
                   height = 8,
                   innerRadius = 90 / 2.0)
{
    difference()
    {
//        %
        roundedDiskRadius = innerRadius + (5 / 2.0);
        roundedDisk(fn = 25,
                    height = height,
                    minkowskiSphereRadius = 2,
                    radius = roundedDiskRadius);

        color("green")
        translate([0,0,cutoutAdjustment])
        cylinder (h = 24, 
                    r= innerRadius, 
                    // center = true, 
                    $fn=50);
    }
}
