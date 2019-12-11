
use <../che-thild.scad>

xyScale = 0.22;

childHeight = 2;

zTranslate = ( (childHeight / 2.0)  - 0.01 );

union()
{
    translate([0, 0, zTranslate])
    scale([xyScale, xyScale, 1])
    theChild(height = childHeight);

    color("blue")
    cylinder(r=20, h=childHeight, center=true); 
}
