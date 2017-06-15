
module chainLoop(xLength = 19,
                 yLength = 12,
                 zLength = 10)
{
    difference()
    {
        color("green")
        cube([xLength, yLength, zLength]);
                
        cutout(xLength, yLength, zLength);
    }
}


module cutout(xLength, yLength, zLength)
{
    zLength = zLength * 0.65;

    zTranslate = zLength / 4.0;
    
    yAxisLength = yLength*0.75;
    
    yTranslate = (yLength / 2.0) - (yAxisLength / 2.0);
    
    // this is the cutout on the Y axis
    translate([-1, yTranslate, zTranslate])
    cube([xLength+3, yAxisLength, zLength]);    
}