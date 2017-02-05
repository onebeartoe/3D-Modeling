
use <around-the-corner-text.scad>

        
textWallLength = 21;        
textWallWidth = 3;
textLeftRightMargin = 2;

color("blue")
rotate([90, 0, 0])
textWall(text="cash me outside",
         length = textWallLength, width = textWallWidth,
         leftRightMargin=textLeftRightMargin);

xTranslate = textWallLength + (textLeftRightMargin * 2);
echo(xTranslate);
translate([xTranslate, 0, 0])
rotate([90, 0, 90])
textWall(text="howbow dah", 
        length = textWallLength, width = textWallWidth,
        leftRightMargin=textLeftRightMargin);