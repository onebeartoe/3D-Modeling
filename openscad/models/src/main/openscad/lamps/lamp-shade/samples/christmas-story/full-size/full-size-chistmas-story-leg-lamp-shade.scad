
bottomOuterRadius = 50;

intersection_xTranslate = -58;

outerRadius = 90;

squareLength = 59;

top_zTranslate = 1;

// this narrows the top (and bottom a little)
xScale = 0.35;  // 0.3;

// this shortens the height and widens the base
yScale = 0.7;   // 0.7;     

use <../christmas-story-lamp-shade.scad>

//translate([-120, 0, 0])
translate([9, 18, 0])
%import("/home/roberto/Versioning/world/betoland/household/lamps/christmas-story-leg-lamp/jetpuf/files/LegLamp_Shade130.stl");

legLampShade(intersection_xTranslate = intersection_xTranslate,
             bottomOuterRadius = bottomOuterRadius,
             outerRadius = outerRadius,
             squareLength = squareLength,
             top_zTranslate = top_zTranslate,
             xScale = xScale,
             yScale = yScale);
