
module chainLoop(xLength = 19,
                 yLength = 12,
                 zLength = 10)
{
    difference()
    {
        color("green")
        cube([xLength, yLength, zLength]);
//        cube([xLength, yLength, zLength], center=true);
                
        cutout(xLength, yLength, zLength);
    }
}

module cutout(xLength, yLength, zLength)
{
    zLength = zLength * 0.65;
    
//    zTranslate = (zLength / 2.0) - (zLength / 2.0);
    zTranslate = zLength / 4.0;
    
    yAxisLength = yLength*0.75;
    
    yTranslate = (yLength / 2.0) - (yAxisLength / 2.0);    
//    yTranslate = (yLength / 2.0) - (yLength*0.75) + 14;
        
    translate([-1, yTranslate, zTranslate])
    cube([xLength+3, yAxisLength, zLength]);
//    cube([xLength*0.75, yLength+1, zLength*0.65], center=true);   // this is the cutout on the Y axis    
}
