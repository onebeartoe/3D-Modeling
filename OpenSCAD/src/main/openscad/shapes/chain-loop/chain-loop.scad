
chainLoop();

module chainLoop(yScale = 12,
                 zScale = 10)
{
    xScale = 19;

    difference()
    {
        color("green")
        cube([xScale, yScale, zScale]);
//        cube([xScale, yScale, zScale], center=true);
                
        cutout(xScale, yScale, zScale);
    }
}

module cutout(xScale, yScale, zScale)
{
    zLength = zScale * 0.65;
    
    zTranslate = (zScale / 2.0) - (zLength / 2.0);
//    zTranslate = zScale / 4.0;
    
    yAxisLength = yScale*0.75;
    
    yTranslate = (yScale / 2.0) - (yAxisLength / 2.0);    
//    yTranslate = (yScale / 2.0) - (yScale*0.75) + 14;
        
    translate([-1, yTranslate, zTranslate])
    cube([xScale+3, yAxisLength, zLength]);
//    cube([xScale*0.75, yScale+1, zScale*0.65], center=true);   // this is the cutout on the Y axis    
}