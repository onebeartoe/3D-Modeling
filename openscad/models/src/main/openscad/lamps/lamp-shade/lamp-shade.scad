
module lampShade(fn = 160,
                 outerRadius = 10,
                 squareLength = 10,
                 xScale = 1.0,
                 yScale = 1.0)
{
    $fn = fn;

    innerRadius = outerRadius - 2.0;

    rotate_extrude(angle = 360)
    translate([-20, 0, 0])
    intersection()
    {
        difference()
        {
            scale([xScale, yScale, 1])
            circle(r = outerRadius, $fn = fn);

            scale([xScale, yScale, 1])
            circle(r = innerRadius,  $fn = fn);
        }

        // use a value of of 0 to invert the shade (widder top)
        translate([0, -squareLength, 0])
        square([squareLength, squareLength]);
    }
}
