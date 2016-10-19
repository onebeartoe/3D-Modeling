
use <../../../crescent-moon/crescent-moon.scad>
use <../../../star/star.scad>

crescentStar();

module crescentStar()
{
    height = 3;

    xyScale = 10;
    scale([xyScale, xyScale,1])
    crescentMoon();
    
    xyTranslate = 25;
    translate([xyTranslate, xyTranslate, 0])
    star();
}