
use <../../triangle/triangle.scad>

module sun(height = 2)
{
    difference()
    {
        sunSegments(height = height);
    
        translate([0, 0, -0.01])
        cylinder($fn=30,
                 h = height,
                 r=4.19);
    }
}

module sunThumbnail(height = 1)
{
    xyScale = 1.63;
    
    scale([xyScale, xyScale, 1])
    sun(height = height);
}

module sunSegments(height)
{    
    segments = 8;
    arch = 360.0 / segments;
    for(i = [1:segments])    
    {
        angle = i * arch;
        rotate ([0, 0, angle])
        translate ([0, 5,0])
        triangle(size=2.25, height = height);
    }
}
