

leftText = "do or do not";
leftFontSize = 6; // [3 : 9]

rightText = "there is no try";
rightFontSize = 6; // [3 : 9]

// default are 21 
leftTextWallLength = 21; // [15 : 30]
rightTextWallLength = 21; // [15 : 30]

// default of next is 3
textWallWidth = 3; //[1,2,3,4,5,6,7]

/* [Hidden] */
textLeftRightMargin = 1; //[1,2,3,4,5,6,7]

union()
{
//    color("blue")
    rotate([90, 0, 0])
    textWall(text=leftText,
             length = leftTextWallLength, width = textWallWidth,
             leftRightMargin=textLeftRightMargin,
             fontSize = leftFontSize);

    xTranslate = leftTextWallLength + textLeftRightMargin
//                                      (textLeftRightMargin * 2) - 
//                                      (textLeftRightMargin / 2.0)
            ;

    translate([xTranslate, 0, 0])
    rotate([90, 0, 90])
    textWall(text=rightText, 
            length = rightTextWallLength, width = textWallWidth,
            leftRightMargin=textLeftRightMargin,
            fontSize = rightFontSize);
}

// The implementation of this script was inspired by the answer provived by Torsten Paul
// in this Stack Overflow question
//          http://stackoverflow.com/questions/39564136/how-to-determine-width-of-text-in-openscad/39564288#39564288


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

/**
 * 
 * @param 
 * @param valign valid values are "top", "center", "baseline" and "bottom". Default is "baseline".
 * @return 
 */
module textExtrude(text, valign = "", font)  
{
    linear_extrude(height=4)
    text(text, font = font, size=6, valign = valign);
}