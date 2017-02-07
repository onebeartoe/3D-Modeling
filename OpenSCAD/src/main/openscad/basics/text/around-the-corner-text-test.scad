
use <around-the-corner-text.scad>

leftText = "cash me outside";
rightText = "howbow dah";

leftTextWallLength = 21;
rightTextWallLength = 21; // 21

textWallWidth = 3; // 3
textLeftRightMargin = 2;

union()
{
    color("blue")
    rotate([90, 0, 0])
    textWall(text=leftText,
             length = leftTextWallLength, width = textWallWidth,
             leftRightMargin=textLeftRightMargin);

    xTranslate = leftTextWallLength + (textLeftRightMargin * 2) - (textLeftRightMargin / 2.0);
    echo(xTranslate);
    translate([xTranslate, 0, 0])
    rotate([90, 0, 90])
    textWall(text=rightText, 
            length = rightTextWallLength, width = textWallWidth,
            leftRightMargin=textLeftRightMargin);
}