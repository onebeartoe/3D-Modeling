
use <../../triangle/triangle.scad>

module sun()
{
    difference()
    {
        sunSegments();
    
        translate([0, 0, -0.01])
        cylinder($fn=30,
                 h = 2,
                 r=4.19);
    }
}

module sunThumbnail()
{
    xyScale = 1.63;
    
    scale([xyScale, xyScale, 1])
    sun();
}

module sunSegments()
{    
    segments = 8;
    arch = 360.0 / segments;
    for(i = [1:segments])    
    {
        angle = i * arch;
        rotate ([0, 0, angle])
        translate ([0, 5,0])
        triangle(size=2.25);
    }
}
