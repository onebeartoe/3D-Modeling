
/* [Base] */

// This parameter is all about that base color.
baseColor = "black"; // [pink, red, black, white, yellow, blue, green]

baseThickness = 2; // [1 : 5]

// This determines how wide the name tag is.
baseWidth = 228;	// [50:600]

// This determines the height of the name tag.
baseHeight = 15; // [54:150]

/* [Border] */
borderColor = "yellow"; // [pink, red, black, white, yellow, blue, green]
showBorder = "No"; // [Yes, No]

/* [Bottom Text] */
bottomText = "Fun Enthusiast";
bottomTextFont = "Arial"; // @FontNamesReplacement@
bottomTextOffsetX = 0; // [-315 : 315]
bottomTextOffsetY = -15; // [-315 : 315]
bottomTextSize = 12; // [0 : 40]

/* [Chain Loop]*/
chainLoop = true;
chainLoopLengthZ = 6;
chainLoopType = "square"; // [rounded, square]
chainLoopPosition = "bottom"; // [bottom, top]

/* [General] */
letterThickness = 3; // [1 : 15]

/* [Icons] */
iconColor = "white"; // [pink, red, black, white, yellow, blue, green]

// This is the x off set of the icons
xIconOffset = -100; // [-200:200]

// This is the y off set of the icons
yIconOffset = 3;  // [1:200]

/* [Left Icon] */
//TODO: Where is the heart icon, man?  "Put your heart into it."
leftIconType = "Moon";   // [Bass Clef, Creeper, Light Bulb, Moon, Rebel, Trooper, Aqua Dude, Cat, Fan, Spur, Mario, Luigi, Sun, Thundercat, Treble Clef]

// This is the X,Y scale of the icons.
leftIconXyScale = 0.99;  // [0.1 : 0.05 : 5]

leftIconHeight = 2.5; // [0.1: 0.1 :5]

/* [Right Icon] */
rightIconHeight = 4.0; // [0.1: 0.1 :5]

//TODO: Where is the heart icon, man?  "Put your heart into it."
rightIconType = "Sun";          // [Bass Clef, Creeper, Light Bulb, Moon, Rebel, Trooper, Aqua Dude, Cat, Fan, Spur, Mario, Luigi, Sun, Thundercat, Treble Clef]

rightIconXyScale = 1.3; // [0.1 : 0.05 : 5]

/* [Top Text] */
topText = "Firstnesto Lastquez";
topTextColor = "white"; // [pink, red, black, white, yellow, blue, green]
topTextFont = "Bauhaus 93"; // @FontNamesReplacement@
topTextSize = 15; // [0 : 40]

/* [Hidden] */

use <../name-tag.scad>

nametag(baseColor = baseColor,
        baseThickness = baseThickness,
        borderColor = borderColor,
        chainLoop = chainLoop,
        chainLoopLengthZ = chainLoopLengthZ,
        chainLoopPosition = chainLoopPosition,
		chainLoopType = chainLoopType,
        iconColor = iconColor,
        letterThickness = letterThickness,
        roundedCorners = true,
        topText = topText,
		topTextOffsetY = 6,
        topTextSize = topTextSize,
        topTextColor = topTextColor,
        topTextFont = topTextFont,
        bottomText = bottomText,
        bottomTextFont = bottomTextFont,
        bottomTextOffsetX = bottomTextOffsetX,
        bottomTextOffsetY = bottomTextOffsetY,
		bottomTextSize = bottomTextSize,
		leftIconXyScale = leftIconXyScale,
        leftIconType = leftIconType,
        leftIconHeight = leftIconHeight,
        rightIconHeight = rightIconHeight,
		rightIconXyScale = rightIconXyScale,
        rightIconType = rightIconType,
        xIconOffset = xIconOffset,
        yIconOffset = yIconOffset,
        baseWidth = baseWidth,
        showBorder = showBorder);
