


module crescentMoon(height = 2)
{    
    $fn = 100;
    
    difference()
    {
        cylinder(r=7, h=height);
        
        xyTranslate = 1.7;
        radius = 5.5;
        translate([xyTranslate, xyTranslate, -1])
        cylinder(r=radius, h=height+2);
    }
}

module crescentMoonThumbnail()
{
    xyScale = 1.7;
    
    scale([xyScale, xyScale, 1])
    crescentMoon();
}