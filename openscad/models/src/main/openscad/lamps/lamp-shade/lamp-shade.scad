
module lampShade(fn = 160,
                 outerRadius = 10,
                 squareLength = 10,
                 xScale = 1.0)
{
    $fn = fn;

    innerRadius = outerRadius - 1;

    rotate_extrude(angle = 360)
    translate([-20, 0, 0])
    intersection()
    {
        difference()
        {
            scale([xScale,1,1])
            circle(r = outerRadius, $fn = fn);

            scale([xScale,1,1])
            circle(r = innerRadius,  $fn = fn);
        }

        square([squareLength, squareLength]);
    }
}
