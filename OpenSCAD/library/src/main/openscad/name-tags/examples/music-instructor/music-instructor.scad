
include <../../name-tag.scad>

//font="../../write/orbitron.dxf";

nametag(borderHeight = 4,
        font=font,
        topText = "Mark",
		topTextFont = "Bauhaus 93",
        topTextOffsetY = 9,
        topTextSize = 18,
        bottomText = "Music Instructor",
        bottomTextOffsetY = -11,
        bottomTextSize = 10,
        leftIconType = "Bass Clef",
        leftIconXyScale = 0.6,
        xIconOffset = 78,
        rightIconType = "Treble Clef",
        rightIconXyScale = 0.25,
        yIconOffset = -0,
        baseWidth = 210,
        baseHeight = 54,
        roundedCorners = false,
        showBorder = "Yes",
        chainLoop = false);
