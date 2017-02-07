
use <around-the-corner-text.scad>

leftText = "cash me outside";
leftFontSize = 6; // [3 : 9]

rightText = "howbow dah";
rightFontSize = 6; // [3 : 9]

// default are 21 
leftTextWallLength = 21; // [15 : 30]
rightTextWallLength = 21; // [15 : 30]

// default of next is 3
textWallWidth = 3; //[1,2,3,4,5,6,7]

textLeftRightMargin = 1; //[1,2,3,4,5,6,7]

union()
{
    color("blue")
    rotate([90, 0, 0])
    textWall(text=leftText,
             length = leftTextWallLength, width = textWallWidth,
             leftRightMargin=textLeftRightMargin,
             fontSize = leftFontSize);

    xTranslate = leftTextWallLength + (textLeftRightMargin * 2) - (textLeftRightMargin / 2.0);
    echo(xTranslate);
    translate([xTranslate, 0, 0])
    rotate([90, 0, 90])
    textWall(text=rightText, 
            length = rightTextWallLength, width = textWallWidth,
            leftRightMargin=textLeftRightMargin,
            fontSize = rightFontSize);
}