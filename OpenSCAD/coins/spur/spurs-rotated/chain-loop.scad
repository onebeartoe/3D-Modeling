
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
    yTranslate = (yScale / 2.0) - (yScale*0.75) + 4;
    zTranslate = zScale / 4.0;
        
    translate([-1, yTranslate, zTranslate])
    cube([xScale+3, yScale*0.75, zScale*0.65]);
//    cube([xScale+1, yScale*0.75, zScale*0.65], center=true);
//    cube([xScale*0.75, yScale+1, zScale*0.65], center=true);   // this is the cutout on the Y axis    
}