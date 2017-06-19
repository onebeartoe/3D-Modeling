
use <../../../name-tag.scad>

iconType = "Fan";
iconXyScale = 0.8;
iconHeight = 3;
        
nametag(baseHeight = 15,
        baseWidth = 80,        
        bottomText = "",
        chainLoop = true,
        chainLoopPosition = "top",
        font="../../../write/orbitron.dxf",
        leftIconHeight = iconHeight,
        leftIconType = iconType,
        leftIconXyScale = iconXyScale,
        rightIconHeight = iconHeight,
        rightIconType = iconType,
        rightIconXyScale = iconXyScale,        
        topText="Fan",
        topTextSize = 12,
        xIconOffset = 33,
        yIconOffset = 1);