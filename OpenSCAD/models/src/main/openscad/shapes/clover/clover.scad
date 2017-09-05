
use <../heart/heart.scad>;

module clover(sideHeartRotation = 100, height = 1)
{
    union () 
    { 
        rotate ([0, 0, sideHeartRotation])
        translate ([0,14,0])
        heart(height=height);

        rotate ([0, 0, 0])
        translate ([0,14,0])
        heart(height=height);

        rotate ([0, 0, -sideHeartRotation])
        translate ([0, 14, 0])
        heart(height=height);

        translate([-3.5,-30,0])
        cube (size = [7, 40, height]);
    }
}

module cloverThumbnail(height=1)
{
    xyScale = 0.38;
    
    scale([xyScale, xyScale, height])
    clover(height = 1);
}