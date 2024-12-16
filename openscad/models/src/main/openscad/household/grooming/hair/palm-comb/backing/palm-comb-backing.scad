

module palmCombBacking(height = 0.8,
                       long = 95 + 5,
                       wide = 77)
{
    // color("black")
    // cube(size = [wide, long, height],
    //      center = true);

    radius = wide / 2.0;

    yTranslate = (long / 2.0) - radius;
    translate([0, yTranslate, 0])
    cylinder(r = radius, h = height,  $fn = 60);

    translate([0, -yTranslate, 0])
    cylinder(r = radius, h = height,  $fn = 60);

    xTranslate = -wide / 2.0;
    yLength = yTranslate * 2;
    color("blue")
    translate([xTranslate, -yLength / 2.0, 0])
    cube([wide, yLength, height]);
}
