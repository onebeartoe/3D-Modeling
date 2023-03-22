
use <HeartScad02.scad>

difference()
{
    halfHeart();

    halfCutout();

    magnetCutout();
}

module halfCutout() 
{
    side = 18;
    height = 5;
    yTranslate = side * 0.4;
    zTranslate = -height * 0.5;

    translate([0,yTranslate,zTranslate])
    cube([side, side, height], center=true);
}

module  halfHeart()
{
    scaleFactor = 0.19;

    rotate([-90,0,0])
    scale([scaleFactor,scaleFactor,scaleFactor])
    oneHeart();
}

module magnetCutout()
{
    $fn = 20;

    // The magnets I have on had are 8mm in diameter. So 4mm is used as the radius.
    translate([0, 7, -19])
    cylinder(r = 4.5, h = 20);
}

