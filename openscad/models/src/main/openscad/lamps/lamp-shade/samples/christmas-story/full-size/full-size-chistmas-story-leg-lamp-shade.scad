
bottomOuterRadius = 52;

intersection_xTranslate = -51;

outerRadius = 90;
//outerRadius = 36;

squareLength = 59;  //28;

top_zTranslate = 5;

xScale = 0.2;       // 0.3;

yScale = 0.7;       // 0.7;

use <../christmas-story-lamp-shade.scad>

//translate([-120, 0, 0])
// translate([9, 18, 0])
// %import("/home/roberto/Versioning/world/betoland/household/lamps/christmas-story-leg-lamp/jetpuf/files/LegLamp_Shade130.stl");

legLampShade(intersection_xTranslate = intersection_xTranslate,
             bottomOuterRadius = bottomOuterRadius,
             outerRadius = outerRadius,
             squareLength = squareLength,
             top_zTranslate = top_zTranslate,
             xScale = xScale,
             yScale = yScale);
