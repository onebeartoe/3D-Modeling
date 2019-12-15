
outerRadius = 36;

squareLength = 28;

xScale = 0.3;

yScale = 0.7;

use <../christmas-story-lamp-shade.scad>

//translate([-120, 0, 0])
//import("/home/roberto/Versioning/world/betoland/household/lamps/christmas-story-leg-lamp/jetpuf/files/LegLamp_Shade130.stl");

legLampShade(bottomOuterRadius = outerRadius * 2,
             outerRadius = outerRadius,
             squareLength = squareLength,
             xScale = xScale,
             yScale = yScale);
