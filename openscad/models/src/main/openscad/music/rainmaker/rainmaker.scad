
use <../../shapes/open-cylinder/open-cylinder.scad>

module rainmaker(height = 140,
                 innerRadius = 30,
                 outerRadius = 34,
			 	 stepRadius = 2)
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
        step_xLength = (innerRadius * 2) + 1;
        rainmaker_steps(height = height,
						stepRadius = stepRadius,
						step_xLength = step_xLength,
                        zStart = zStart);

        // the bottom
        cylinder(r=outerRadius, h=bottomZ);
    }
}

module rainmaker_steps(height,
						stepRadius,
						step_xLength,
						zStart)
{
    step = 5;

//	stepRadius = 2;

	zEnd = height - step - stepRadius;

    for(z = [zStart : step : zEnd])
    {
		xTranslate = 0;
        zTranslate = zStart + z;

		zRotate = z * 25;

        translate([xTranslate, 0, zTranslate])
		rotate([0, 90, zRotate])
        cylinder(r = stepRadius,
					h = step_xLength,
					center = true);
    }
}
