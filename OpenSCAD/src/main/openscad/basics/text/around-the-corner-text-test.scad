
use <around-the-corner-text.scad>

leftText = "cash me outside";
rightText = "howbow dah";

textWallLength = 21; // 21
rightTextWallLength = 29;
textWallWidth = 3;
textLeftRightMargin = 2;

color("blue")
rotate([90, 0, 0])
textWall(text=leftText,
         length = textWallLength, width = textWallWidth,
         leftRightMargin=textLeftRightMargin);

xTranslate = textWallLength + (textLeftRightMargin * 2) - (textLeftRightMargin / 2.0);
echo(xTranslate);
translate([xTranslate, 0, 0])
rotate([90, 0, 90])
textWall(text=rightText, 
        length = textWallLength, width = textWallWidth,
        leftRightMargin=textLeftRightMargin);