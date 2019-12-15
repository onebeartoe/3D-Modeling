

outerRadius = 12;

squareLength = 28;

xScale = 0.4;

yScale = 1.9;

bottomOuterRadius = 20;

use <../christmas-story-lamp-shade.scad>

translate([-120, 0, 0])
import("/home/roberto/Versioning/world/betoland/household/lamps/christmas-story-leg-lamp/jetpuf/files/LegLamp_Shade130.stl");

legLampShade(bottomOuterRadius = bottomOuterRadius,
             outerRadius = outerRadius,
             squareLength = squareLength,
             xScale = xScale,
             yScale = yScale);
