
use <../../basics/rounded-edges/doughnuts/doughnuts.scad>

/**
 * The end with the short tube goes toward the top and connects to the bead chain.
 * The end with the long tube attaches to the circle clasp.
 */

module base(cornerRadius, yLength, zLength)
{
    rectangularDoughnut(cornerRadius, yLength, zLength);
}

module beadChainAttacher(cornerRadius = 2, yLength = 33, zLength = 35)
{
    union()
    {
        base(cornerRadius, yLength, zLength);
        
        beadHolder(zLength);
    }
}

module beadHolder(zLength)
{
    rotate([0, 0, -15])
    translate([123, -100, zLength])
    import("bead_chain_hanger.stl", center = true);
}