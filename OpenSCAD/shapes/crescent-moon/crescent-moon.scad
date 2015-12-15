
$fn = 100;

crescentMoon();

module crescentMoon(height = 3)
{    
    difference()
    {
        cylinder(r=7, h=height);
        
        xyTranslate = 1.7;
        radius = 5.5;
        translate([xyTranslate, xyTranslate, -1])
        cylinder(r=radius, h=height+2);
    }
}