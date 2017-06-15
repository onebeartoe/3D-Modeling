
module chainLoop(xLength = 19,
                 yLength = 12,
                 yPercentage = 0.75,
                 zLength = 10,
                 zPercentage = 0.65)
{
    difference()
    {
        color("green")
        cube([xLength, yLength, zLength]);
                        
        cutout(xLength, yLength, yPercentage, zLength, zPercentage);
    }
}

/**
 * This module takes the cubic lengths of the chain loop and calculates the 
 * cutout dimensions based on the percentages given.
 * 
 * The percentages are expected to be of type float with 1 being 100%.
 */
module cutout(xLength,
              yLength,
              yPercentage,
              zLength,
              zPercentage
        )
{
    zCutoutLength = zLength * zPercentage;
    zTranslate = (zLength/2.0) - (zCutoutLength / 2.0);
    
    yCutoutLength = yLength * yPercentage;

    yTranslate = (yLength / 2.0) - (yCutoutLength / 2.0);
    
    // this is the cutout on the X axis
    translate([-1, yTranslate, zTranslate])
    cube([xLength+3, yCutoutLength, zCutoutLength]);    
}