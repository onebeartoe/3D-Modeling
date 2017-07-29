
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

        xTranslate = 120;
        yTranslate = -106;
        zTranslate = zLength + cornerRadius;
        beadHolder(xTranslate, yTranslate, zTranslate);
    }
}

module beadHolder(xTranslate, yTranslate, zTranslate)
{
//    rotate([0, 0, 45])
    rotate([0, 0, -35])
    translate([xTranslate, yTranslate, zTranslate])
    import("bead_chain_hanger.stl");//, center = true);
}