
module copperGolem(headRotation_z = 0,
                    rightArmRotation_x = 0)
{
    // Head
    translate([2, 2, 14])
    {
        color("orange")
        rotate ([0, 0, headRotation_z])
        translate ([1, 0])
        rotate([0, 0, -headRotation_z])
        cube([4, 4, 4], center=false);
    }

    // Body
    translate([0, 0, 6])
    {
        color("green")
        cube([8, 8, 8]);
    }

    // Legs
    translate([0, 2, 0])
    {
        color("pink")
        cube([2, 2, 8]);
    }

    translate([6, 2, 0])
    {
        color("pink")
        cube([2, 2, 8]);
    }

    // Arms
    translate([-2, 0, 10])
    {
        // left arm
        color("red")
        cube([2, 2, 8]);
    }

    translate([8, 3, 11])
    {
        // right arm
        color("red")
        rotate([rightArmRotation_x, 0, 0])
        cube([2, 2, 8]);
    }

    // Eyes
    translate([2, 2, 8])
    {
        color("white")
        cube([2, 2, 2]);
    }

    translate([4, 2, 8])
    {
        color("white")
        cube([2, 2, 2]);
    }
}

