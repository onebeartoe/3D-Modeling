
use <letter-key.scad>

keyCapString(["H", "e","l","l","o"," ", "w","o","r","l","d"], xUppercaseOffset);

rowSpacing = -50;
xLowercaseOffset = -37;
translate([0, rowSpacing, 0])
aphabetCaps(xLowercaseOffset);

translate([0, rowSpacing*2, 0])
aphabetCaps(xOffset=xLowercaseOffset, font = "Arial:style=Bold");

xUppercaseOffset = xLowercaseOffset - 0.5;
translate([0, rowSpacing*3, 0])
uppercaseAphabetCaps(xUppercaseOffset);

font = "Wingdings";//:style=Italic";
translate([0, rowSpacing*4, 0])
uppercaseAphabetCaps(xOffset=xUppercaseOffset, font=font);		
		