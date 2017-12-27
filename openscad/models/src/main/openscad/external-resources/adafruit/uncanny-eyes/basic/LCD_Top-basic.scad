
use <../LCD_Top.scad>

uncannyEyes_lcdTop();

xLength = 46.589;
yLength = 48.0;
cubeZ = 6;
cubeTranslateY = cubeZ / 2.0;
color("pink")
translate([0, 0, cubeTranslateY])
cube([xLength, yLength, cubeZ], center=true);
