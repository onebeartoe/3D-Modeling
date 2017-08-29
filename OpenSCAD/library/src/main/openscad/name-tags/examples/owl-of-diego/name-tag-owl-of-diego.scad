
include <../../name-tag.scad>

font="../../write/orbitron.dxf";

nametag(font=font,
        xIconOffset = 40,
        yIconOffset = 5,
        leftIconType = "-none-",
        leftIconHeight = 4,
        rightIconType = "-none-",
        rightIconHeight = 4,
        rightIconXyScale = 1,
        topText = "tecolote",
		topTextFont = "Bauhaus 93",
        topTextSize = 12,
        bottomText = "",
        baseWidth = 58,
        baseHeight = 15,
        roundedCorners = true,
        chainLoop = true,
        chainLoopLengthZ = 3,
        chainLoopPosition = "bottom");
