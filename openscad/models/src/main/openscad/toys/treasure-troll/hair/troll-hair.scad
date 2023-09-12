
module trollHair(hairLength = 50,
                 hairRadius = 0.28,
                 squareSide = 30,
                 step = 0.8)
{
    union()
    {
        wall(squareSide);

        for(y = [0.4 : step : squareSide])
        {
            for(z = [0.4 : step : squareSide])
            {
                color("orange")
                translate([0, y, z])
                rotate([0, 90, 0])
                cylinder(r=hairRadius, h=hairLength);
            }
        }

        translate([hairLength-0.5, 0, 0])
        wall(squareSide);
    }
}

module wall(squareSide)
{
    cube([1, squareSide, squareSide]);
}
