
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
        topTextSize = 12,
        bottomText = "",
        baseWidth = 58,
        baseHeight = 15,
        roundedCorners = true,
        chainLoop = true,
        chainLoopPosition = "bottom");
