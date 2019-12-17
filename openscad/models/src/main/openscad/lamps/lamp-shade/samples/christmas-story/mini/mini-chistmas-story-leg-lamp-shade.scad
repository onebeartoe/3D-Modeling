
intersection_xTranslate = -20;

outerRadius = 12;

squareLength = 28;

xScale = 0.4;

yScale = 1.9;

bottomOuterRadius = 20;

use <../christmas-story-lamp-shade.scad>

//translate([10, 10, 0])
// translate([-80, 0, 0])
// import("/home/roberto/Versioning/world/betoland/household/lamps/christmas-story-leg-lamp/jetpuf/files/LegLamp_Shade130.stl");

legLampShade(bottomOuterRadius = bottomOuterRadius,
             intersection_xTranslate = intersection_xTranslate,
             outerRadius = outerRadius,
             squareLength = squareLength,
             xScale = xScale,
             yScale = yScale);
