
use <name-tag.scad>

/* [Icons] */
iconColor = "white"; // [pink, red, black, white, yellow, blue, green]        
leftIconType = "Bass Clef"; // [Creeper, Light Bulb, Rebel, Trooper, Aqua Dude, Cat, Fan, Spur, Mario, Luigi, Thundercat, Bass Clef, Treble Clef]        
rightIconType = "Light Bulb";         // [Creeper, Light Bulb, Rebel, Trooper, Aqua Dude, Cat, Fan, Spur, Mario, Luigi, Thundercat, Bass Clef, Treble Clef]

// This is the x off set of the icons
xIconOffset = 36; // [10:200]

// This is the x off set of the icons
yIconOffset = 3;  // [1:200]
        
// This is the X,Y scale of the icons.
leftIconXyScale = 0.5;  // [0.1 : 0.05 : 5]

rightIconXyScale = 0.25; // [0.1 : 0.05 : 5]

leftIconHeight = 1.5; // [0.1: 0.1 :5]
rightIconHeight = 1.5; // [0.1: 0.1 :5]

/* [General] */
letterThickness = 3; // [1 : 15]

/* [Top Text] */
topText = "Love is the Answer";
topTextColor = "white"; // [pink, red, black, white, yellow, blue, green]

//font="write/orbitron.dxf";

/* [Bottom Text] */
bottomText = "";

/* [Base] */
// This determines how wide the name tag is.
baseWidth = 46;//228;	// [228:600]	
//baseWidth = 180;

// This determines the hieght of the nametag.
baseHeight = 15; // [54:150]

/* [Border] */
borderColor = "yellow"; // [pink, red, black, white, yellow, blue, green]
showBorder = "No"; // [Yes, No]

nametag(iconColor = iconColor,
        letterThickness = letterThickness,
        topText = topText,
        topTextSize = 7,
        topTextColor = topTextColor,
        bottomText = bottomText,
        font=font,
        leftIconType = leftIconType,
        leftIconHeight = leftIconHeight,
        rightIconType = rightIconType,
        rightIconHeight = rightIconHeight,
        xIconOffset = xIconOffset,
        yIconOffset = yIconOffset,
        baseWidth = baseWidth,
        showBorder = showBorder);
