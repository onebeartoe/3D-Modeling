
module chainLoop(cutoutAxis = "x",
				 xLength = 19,
				 xPercentage = 0.70,
                 yLength = 12,
                 yPercentage = 0.75,
                 zLength = 10,
                 zPercentage = 0.65)
{
    difference()
    {
        color("green")
        cube([xLength, yLength, zLength]);
        cutout(cutoutAxis,
				xLength,
				xPercentage,
				yLength,
				yPercentage,
				zLength,
				zPercentage);
    }
}

/**
 * This module takes the cubic lengths of the chain loop and calculates the
 * dimensions of the cot out protion based on the percentages given.
 *
 * The percentages are expected to be of type float with 1 being 100%.
 */
module cutout(cutoutAxis = "x",
			  xLength = 5,
			  xPercentage = 0.2,
              yLength,
              yPercentage,
              zLength,
              zPercentage)
{
	if(cutoutAxis == "x")
	{
		zCutoutLength = zLength * zPercentage;
	    zTranslate = (zLength/2.0) - (zCutoutLength / 2.0);

	    yCutoutLength = yLength * yPercentage;
	    yTranslate = (yLength / 2.0) - (yCutoutLength / 2.0);

	    translate([-1, yTranslate, zTranslate])
	    cube([xLength+3, yCutoutLength, zCutoutLength]);
	}
	else if(cutoutAxis == "z")
	{
	    yCutoutLength = yLength * yPercentage;
	    yTranslate = (yLength / 2.0) - (yCutoutLength / 2.0);

		xCoutoutLength = xLength * xPercentage;
		xTranslate = (xLength / 2.0) - (xCoutoutLength / 2.0);

		translate([xTranslate, yTranslate, -1])
	    cube([xCoutoutLength, yCutoutLength, zLength+3]);
	}
}
