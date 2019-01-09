
use <../../shapes/open-cylinder/open-cylinder.scad>

module rainmaker(height = 140,
                 innerRadius = 30,
                 outerRadius = 34,
				 rungsPerLevel = 1,
				 shellDecoration = "none",
				 showShell = "yes",
			 	 stepRadius = 2,
				 zDistanceBetweenRungs = 5,
			 	 zRotateAngle = 25)
{
    union()
    {
        // the main shell
		if(showShell == "yes")
		{
    		#
	        openCylinder(height = height,
	                     innerRadius = innerRadius,
	                     outerRadius = outerRadius);
		}

        bottomZ = 5;

        // the steps
        zStart = bottomZ;
        step_xLength = (innerRadius * 2) + 1;
        rainmaker_steps(height = height,
						outerRadius = outerRadius,
						rungsPerLevel = rungsPerLevel,
						shellDecoration = shellDecoration,
						stepRadius = stepRadius,
						step_xLength = step_xLength,
						zDistanceBetweenRungs = zDistanceBetweenRungs,
						zRotateAngle = zRotateAngle,
                        zStart = zStart);

        // the bottom
        cylinder(r=outerRadius, h=bottomZ);
    }
}

// suport modules follow

module rainmaker_steps(height,
						outerRadius,
						rungsPerLevel,
						shellDecoration,
						stepRadius,
						step_xLength,
						zDistanceBetweenRungs,
						zRotateAngle,
						zStart)
{
	zEnd = height - zDistanceBetweenRungs - stepRadius;

    for(z = [zStart : zDistanceBetweenRungs : zEnd])
    {
		xTranslate = 0;
        zTranslate = zStart + z;

		rotate([0, 0, zRotateAngle * z])
		union()
		{
			for(s = [1 : 1 : rungsPerLevel])
			{
				union()
				{
					stepColor  = s == 1 ? "yellow" :
								 s == 2 ? "green" :
								 s == 3 ? "orange" :
								 s == 4 ? "blue" :
								          "pink";

					angleDivision = 360.0 / rungsPerLevel;
				    zRotate = (angleDivision * (s-1) ) / 2;

					color(stepColor)
			        translate([xTranslate, 0, zTranslate])
					rotate([0, 90, zRotate])
			        cylinder(r = stepRadius,
								h = step_xLength,
								center = true);

					if(shellDecoration == "bumps")
					{
// The commented code below is to help debug why rotaion is not working for the bump.
// And it will be removed hopefully soon.						
//						bumpsRotate = (angleDivision * s) / s;
//						bumpsRotate = zRotate / s;
						bumpsRotate = zRotate;
//						bumpsRotate = s + 30;
//						bumpsRotate = 0;

//						echo("bumps", s, bumpsRotate);

						color(stepColor)
						translate([outerRadius, 0, zTranslate])
//rotate([bumpsRotate, 0, 0])
//rotate([0, 90, bumpsRotate])
						sphere(r=3);

// this is the bump on the 'other' end
						color(stepColor)
						translate([-outerRadius, 0, zTranslate])
//						rotate([0, 90, bumpsRotate * s])
						sphere(r=3);
					}
				}
			}
		}
    }
}
