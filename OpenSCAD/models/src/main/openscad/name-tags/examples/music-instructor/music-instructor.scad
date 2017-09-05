
include <../../name-tag.scad>

//font="../../write/orbitron.dxf";

nametag(baseWidth = 210,
        baseHeight = 54,
		borderHeight = 4,
		bottomText = "Music Instructor",
		bottomTextFont = "Bauhaus 93",
        bottomTextOffsetY = -11,
        bottomTextSize = 10,
		chainLoop = false,
        topText = "Mark",
		topTextFont = "Bauhaus 93",
        topTextOffsetY = 9,
        topTextSize = 18,
        leftIconType = "Bass Clef",
        leftIconXyScale = 0.6,
        xIconOffset = 78,
        rightIconType = "Treble Clef",
        rightIconXyScale = 0.25,
        yIconOffset = -0,
        roundedCorners = false,
        showBorder = "Yes");
