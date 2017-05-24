
use <../../../name-tag.scad>

iconType = "Fan";
iconXyScale = 0.8;
iconHeight = 3;
        
nametag(topText="Fan",
        topTextSize = 12,
        bottomText = "",
        font="../../../write/orbitron.dxf",
        
        leftIconType = iconType,
        leftIconHeight = iconHeight,
        leftIconXyScale = iconXyScale,
        rightIconType = iconType,
        rightIconHeight = iconHeight,
        rightIconXyScale = iconXyScale,
        xIconOffset = 33,
        yIconOffset = 1,
        
        baseWidth = 80,
        baseHeight = 15,
//        showBorder = "No",
//        showBorder = "Yes",        
        chainLoop = true,
        chainLoopPosition = "top");
