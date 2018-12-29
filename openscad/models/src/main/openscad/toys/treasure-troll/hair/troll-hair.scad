
hairLength = 50;

hairRadius = 0.28;

squareSide = 30;

union()
{
    wall();

    step = 0.8;
    for(y = [0.4 : step : squareSide])
    {
        for(z = [0.4 : step : squareSide])
        {
            translate([0, y, z])
            rotate([0, 90, 0])
            cylinder(r=hairRadius, h=hairLength);
        }
    }

    translate([hairLength-0.1, 0, 0])
    wall();
}
module wall()
{
    cube([1, squareSide, squareSide]);
}
