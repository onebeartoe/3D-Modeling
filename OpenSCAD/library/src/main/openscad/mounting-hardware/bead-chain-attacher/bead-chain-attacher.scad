
use <../../basics/rounded-edges/doughnuts/doughnuts.scad>

/**
 * The end with the short tube goes toward the top and connects to the bead chain.
 * The end with the long tube attaches to the circle clasp.
 */



module base(zLength)
{
    rectangularDoughnut(zLength);
}

module beadChainAttacher(zLength = 35)
{
    union()
    {
        base();
//        base(zLength);
        
        beadHolder(zLength);
    }
}

module beadHolder(zLength)
{
    translate([123, -100, zLength])
    import("bead_chain_hanger.stl", center = true);
}