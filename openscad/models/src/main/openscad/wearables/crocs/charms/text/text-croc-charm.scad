
use <../../../../wearables/crocs/charms/led/croc-led-jiblet.scad>

use <../../../../basics/text/text-around-the-corner/around-the-corner-text.scad>
                 
module textCrocCharm(font = "Bauhaus 93:style=Regular",
                     height = 2,
                     leftRightMargin = 2,
                     length = 9,
                     text = "default text",
                     wallThinkness = 1,
                     width = 4)
{
    echo("text charm");

    union()
    {
        zTranslate = -(height + wallThinkness + 0.1);
        rotate([0,180,0])
        translate([0, 0, zTranslate])
        textWall(fontName = font,
                 textHeight = height,
                 leftRightMargin = leftRightMargin,
                 text = text);

        jibletTranlsate_x = -(length + (leftRightMargin * 2)    ) / 3.0 ;
        jibletTranlsate_y = (width) / 4.0;

        connectorHeight = 2;
        connectorTranslate_z = (zTranslate + height + 0.51) * -11.9 + .5;
        
        jibletTranlsate_z = connectorTranslate_z + connectorHeight - 0.1;        
        color("purple")
        translate([jibletTranlsate_x, jibletTranlsate_y, 3 - 0.1])
        cylinder(
           r=5, 
            // r=9, 
                h=connectorHeight);
    
        translate([jibletTranlsate_x, jibletTranlsate_y, jibletTranlsate_z - 0.2])
        textCrocCharm_jiblet();
    }
}


module textCrocCharm_jiblet()
{
    rotate([0,180,0])
    blank();
}