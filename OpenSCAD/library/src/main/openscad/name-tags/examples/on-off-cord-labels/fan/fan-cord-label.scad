
use <../../../name-tag.scad>

iconType = "Fan";
iconXyScale = 0.8;
iconHeight = 3;

nametag(baseHeight = 15,
        baseWidth = 80,
        bottomText = "",
        chainLoop = true,
        chainLoopLengthPercentageY = 0.6,
        chainLoopLengthPercentageZ = 0.45,
        chainLoopLengthZ = 6,
        chainLoopPosition = "top",
//        font="../../../write/orbitron.dxf",
        leftIconHeight = iconHeight,
        leftIconType = iconType,
        leftIconXyScale = iconXyScale,
        rightIconHeight = iconHeight,
        rightIconType = iconType,
        rightIconXyScale = iconXyScale,
        topText="Fan",
		topTextFont = "Arial",
        topTextSize = 12,
        xIconOffset = 33,
        yIconOffset = 1);
