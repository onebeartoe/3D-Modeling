
bottomOuterRadius = 52;

intersection_xTranslate = -20;

outerRadius = 90;
//outerRadius = 36;

squareLength = 50;  //28;

xScale = 0.1;       // 0.3;

yScale = 0.3;       // 0.7;

use <../christmas-story-lamp-shade.scad>

//translate([-120, 0, 0])
// translate([9, 18, 0])
// import("/home/roberto/Versioning/world/betoland/household/lamps/christmas-story-leg-lamp/jetpuf/files/LegLamp_Shade130.stl");

legLampShade(intersection_xTranslate = intersection_xTranslate,
             bottomOuterRadius = bottomOuterRadius,
             outerRadius = outerRadius,
             squareLength = squareLength,
             xScale = xScale,
             yScale = yScale);
