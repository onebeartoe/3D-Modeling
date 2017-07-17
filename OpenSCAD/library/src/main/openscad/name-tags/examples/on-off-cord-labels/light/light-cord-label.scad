
use <../../../name-tag.scad>

iconType = "Light Bulb";
iconXyScale = 0.8;
iconHeight = 3;
        
nametag(baseWidth = 80,
        baseHeight = 15,        
        bottomText = "",
        chainLoop = true,
        chainLoopLengthPercentageY = 0.6,
        chainLoopLengthPercentageZ = 0.45,
        chainLoopLengthZ = 6,
        chainLoopPosition = "top",
//        font="../../../write/orbitron.dxf",        
        leftIconType = iconType,
        leftIconHeight = iconHeight,
        leftIconXyScale = iconXyScale,
        rightIconType = iconType,
        rightIconHeight = iconHeight,
        rightIconOffsetY = 3,
        rightIconXyScale = iconXyScale,
        topText="Light",
        topTextSize = 12,
        xIconOffset = 36,
        yIconOffset = 3);