
/**
 * The end with the short tube goes toward the top and connects to the bead chain.
 * The end with the long tube attaches to the circle clasp.
 */

module base()
{
    
}

module beadChainAttacher(baseOffset)
{
    union()
    {
        base()
        
        beadHolder();

        ring();
        
        echo("fart)");
    }
}

module beadHolder()
{
//    rotate([90, 0, -29])//-29])
    translate([123,-119,0])
//    rotate([0, 0, 0])
    import("bead_chain_hanger.stl", center = true);
}

module ring()
{
    
}