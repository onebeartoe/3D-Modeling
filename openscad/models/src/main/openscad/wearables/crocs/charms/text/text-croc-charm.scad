
// use <../../../../basics/text/text-extrude/text-extrude.scad>

use <../../../../basics/text/tex-around-the-corner/around-the-corner-text.scad>

module textCrocCharm(font = "",
                     height=4,
                     text = "default text")
{
    echo("text charm");

    union()
    {


        rotate([0,180,0])
        translate([0,0,-height])
        textWall(
        // textExtrude(
                    fontName = font,
                    height = height,
                    text = text);
    }
}
