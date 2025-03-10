
use <../../name-tag.scad>

iconType = "Light Bulb";
iconXyScale = 0.8;
iconHeight = 3;

nametag(baseWidth = 80,
        baseHeight = 15,
        bottomText = "",
        chainLoop = true,
		chainLoopType = "rounded",
        leftIconType = iconType,
        leftIconHeight = iconHeight,
        leftIconXyScale = iconXyScale,
        rightIconType = iconType,
        rightIconHeight = iconHeight,
        rightIconOffsetY = 3,
        rightIconXyScale = iconXyScale,
        topText = "Light",
		topTextFont = "Bauhaus 93",
		topTextOffsetY = -1.5,
        topTextSize = 16,
        xIconOffset = 36,
        yIconOffset = 3);
