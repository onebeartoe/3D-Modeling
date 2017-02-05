
// The implementation of this script was inspired by the answer provived by Torsten Paul
// in this Stack Overflow question
//          http://stackoverflow.com/questions/39564136/how-to-determine-width-of-text-in-openscad/39564288#39564288

use <text-extrude.scad>

module textWall(text = "cash me outside", length = 20, w = 10)
{
    difference() 
    {
        textXOffset = 2;
        cubeLength = length + (textXOffset * 2);
        cubeWidth = w;        
        cube([cubeLength, cubeWidth, 1]);

        color("white")
            translate([textXOffset, w / 2.0, 0.6])
                linear_extrude(1, convexity = 4)
                    resize([length, 0, 0], auto = true)
                        text(text=text, valign = "center");
    }
}