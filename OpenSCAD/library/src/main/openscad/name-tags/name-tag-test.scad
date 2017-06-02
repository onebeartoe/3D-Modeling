
use <name-tag.scad>

/* [Icons] */
leftIconType = "Bass Clef";    // [Rebel, Trooper, Aqua Dude, Cat, Fan, Spur, Mario, Luigi, Thundercat, Bass Clef, Treble Clef]        

// This is the x off set of the icons
xIconOffset = 36; // [10:200]

// This is the x off set of the icons
yIconOffset = 3;  // [1:200]
        
// This is the X,Y scale of the icons.
// For the Thingiverse Customizer, the music note XY scale is 0.6 and 0.3
leftIconXyScale = 0.5;  // [0.1 : 0.05 : 5]

rightIconType = "Light Bulb";
rightIconXyScale = 0.25; // [0.1 : 0.05 : 5]

leftIconHeight = 1.5; // [0.1: 0.1 :5]
rightIconHeight = 1.5; // [0.1: 0.1 :5]

/* [Top Text] */
topText = "Love is the Answer!";
topTextColor = "white"; // [pink, red, black, white, yellow, blue, green]

font="write/orbitron.dxf";

/* [Bottom Text] */
bottomText = "";

/* [Base] */
// This determines how wide the name tag is.
baseWidth = 46;//228;	// [228:600]	
//baseWidth = 180;

// This determines the hieght of the nametag.
baseHeight = 15;//54;	// [54:150]



/* [Border] */
showBorder = "No"; // [Yes, No]

nametag(topText = topText,
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
