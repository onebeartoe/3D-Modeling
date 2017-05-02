
use <name-tag.scad>

/* [Icons] */
        
// leftIconType and rightIconType are passed to the oneIcon() module
leftIconType = "Bass Clef";//"Bass Clef";    // [Rebel, Trooper, Aqua Dude, Cat, Spur, Mario, Luigi, Thundercat, Bass Clef, Treble Clef]        


// This is the x off set of the icons
xOffset = 87; // [10:200]

// This is the X,Y scale of the icons.
// For the Thingiverse Customizer, the music note XY scale is 0.6 and 0.3
leftIconXyScale = 0.5;  // [0.1 : 0.05 : 5]
rightIconXyScale = 0.25; // [0.1 : 0.05 : 5]

leftIconHeight = 1.5; // [0.1: 0.1 :5]
rightIconHeight = 1.5; // [0.1: 0.1 :5]

/* [Top Text] */
topText = "Love is the Answer"
        
font="write/orbitron.dxf";
baseWidth = 180;
showBorder = "No"; // [Yes, No]

nametag(topText = topText,
        topTextSize = 7,
        font=font,
        leftIconType = leftIconType,
        leftIconHeight = leftIconHeight,
        rightIconHeight = rightIconHeight,
        xOffset = 87,
        baseWidth = baseWidth,
        showBorder = showBorder);
