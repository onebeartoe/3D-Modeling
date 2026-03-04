
module emptyCube(x, y, z, thickness) 
{
    difference() 
    {
        // Outer box
        cube([x, y, z]);

        // Inner box
        // To create a box with an open top, the inner box should be offset by 'thickness' in X, Y, and Z.
        // It should extend to the top of the outer cube to remove the top face.
        // Its dimensions will be x - 2*thickness, y - 2*thickness, z
        translate([thickness, thickness, thickness]) 
        {
            cube([x - 2 * thickness, y - 2 * thickness, z]);
        }
    }
}
