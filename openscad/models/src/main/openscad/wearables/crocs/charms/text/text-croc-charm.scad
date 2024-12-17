
use <../../../../wearables/crocs/charms/led/croc-led-jiblet.scad>

use <../../../../basics/text/text-around-the-corner/around-the-corner-text.scad>
                 
module textCrocCharm(font = "",
                     height=4,
                     leftRightMargin=2,
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

        jibletTranlsate_x = -(length + (leftRightMargin * 2)    ) / 2.0 ;
        jibletTranlsate_y = (width) / 2.0;
        jibletTranlsate_z = -(zTranslate) + height + 0.4999;    
        translate([jibletTranlsate_x, jibletTranlsate_y, jibletTranlsate_z])
        textCrocCharm_jiblet();
    }
}


module textCrocCharm_jiblet()
{
    translate([0, 0, 0])
    rotate([0,180,0])
    blank();
}