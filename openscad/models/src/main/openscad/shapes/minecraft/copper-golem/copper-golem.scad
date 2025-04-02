



module copperGolem()
{
    // Head
    translate([2, 2, 14])
    {
        color("orange")
        cube([4, 4, 4]);
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
        color("red")
        cube([2, 2, 8]);
    }

    translate([8, 0, 10])
    {
        color("red")
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

