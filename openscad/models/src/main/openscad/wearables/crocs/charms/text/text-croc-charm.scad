
// use <../../../../basics/text/text-extrude/text-extrude.scad>

use <../../../../basics/text/text-around-the-corner/around-the-corner-text.scad>
                 
module textCrocCharm(font = "",
                     height=4,
                     text = "default text",
                     wallThinkness = 1)
{
    echo("text charm");

    union()
    {
        zTranslate = (-height + wallThinkness) / 2.0;
        rotate([0,180,0])
        translate([0, 0, zTranslate])
        textWall(fontName = font,
                 height = height,
                 leftRightMargin=2,
                 text = text);

        
    }
}
