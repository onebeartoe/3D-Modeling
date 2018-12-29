
use <../../shapes/open-cylinder/open-cylinder.scad>

module rainmaker(height = 140,
                 innerRadius = 30,
                 outerRadius = 34)
{
    union()
    {
        // the main shell
    	%
        openCylinder(height = height,
                     innerRadius = innerRadius,
                     outerRadius = outerRadius);

        bottomZ = 5;

        // the steps
        zStart = bottomZ;
        step_xLength = innerRadius * 2;
        rainmaker_steps(step_xLength = step_xLength,
                        zStart = zStart);

        // the bottom
        cylinder(r=outerRadius, h=bottomZ);
    }
}

module rainmaker_steps(step_xLength, zStart)
{
    step = 5;

    for(z = [zStart : step : 30])
    {
        xTranslate = -step_xLength / 2.0;
        zTranslate = zStart * z;

        translate([xTranslate, 0, zTranslate])
        rotate([0, 90, 0])
        cylinder(r = 2, h = step_xLength);
    }

}
