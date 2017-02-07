
// The implementation of this script was inspired by the answer provived by Torsten Paul
// in this Stack Overflow question
//          http://stackoverflow.com/questions/39564136/how-to-determine-width-of-text-in-openscad/39564288#39564288

use <text-extrude.scad>

module textWall(text = "this is a text", length = 20, width = 10, leftRightMargin=2, fontSize = 6)
{
    font = "Bauhaus 93:style=Regular";
    
    union()
    {
        textXOffset = leftRightMargin;
        cubeLength = length + (textXOffset * 2);
        cubeWidth = width;
        cube([cubeLength, cubeWidth, 1]);

        color("white")
        translate([textXOffset, width / 2.0, 0.6])
        linear_extrude(1, convexity = 4)
        resize([length, cubeWidth * 0.9, 0], auto = true)
        text(text=text, valign = "center", font = font, size=fontSize);
    }
}