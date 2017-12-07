
use <../triangle/triangle.scad>

module arrow()
{
    union()
    {
        triangle(size = 5);

        xLength = 2;
        yLength = 10;
        xTranslate = -xLength / 2.0;
        yTranslate = -yLength;
        translate([xTranslate, yTranslate, 0])
        cube([xLength, yLength, 1]);
    }
}

module arrowThumbnail()
{
    xyScale = 1.62;
    yTranslate = 4.05;
    translate([0, yTranslate, 0])
    scale([xyScale, xyScale, 1])
    arrow();
}

module rightArrowThumbnail()
{
    rotate([0, 0, -90])
    arrowThumbnail();
}
