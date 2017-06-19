
use <../../../name-tag.scad>

iconType = "Light Bulb";
iconXyScale = 0.8;
iconHeight = 3;
        
nametag(topText="Light",
        topTextSize = 12,
        bottomText = "",
        font="../../../write/orbitron.dxf",
        
        leftIconType = iconType,
        leftIconHeight = iconHeight,
        leftIconXyScale = iconXyScale,
        rightIconType = iconType,
        rightIconHeight = iconHeight,
        rightIconOffsetY = 3,
        rightIconXyScale = iconXyScale,
        xIconOffset = 36,
        yIconOffset = 3,
        
        baseWidth = 80,
        baseHeight = 15,
        
        chainLoop = true,
        chainLoopLengthZ = 3,
        chainLoopPosition = "top");