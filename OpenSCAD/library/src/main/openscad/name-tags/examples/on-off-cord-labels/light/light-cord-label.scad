
use <../../../name-tag.scad>

iconType = "Light Bulb";
iconXyScale = 0.8;
iconHeight = 3;

nametag(baseWidth = 80,
        baseHeight = 15,
        bottomText = "",
        chainLoop = true,
		chaneLoopCutoutAxis = "z",
        chainLoopLengthPercentageY = 0.5,
//        chainLoopLengthPercentageX = 0.945,
        chainLoopLengthZ = 5,
        chainLoopPosition = "top",
        leftIconType = iconType,
        leftIconHeight = iconHeight,
        leftIconXyScale = iconXyScale,
        rightIconType = iconType,
        rightIconHeight = iconHeight,
        rightIconOffsetY = 3,
        rightIconXyScale = iconXyScale,
        topText="Light",
		topTextFont = "Bauhaus 93",
        topTextSize = 12,
        xIconOffset = 36,
        yIconOffset = 3);
