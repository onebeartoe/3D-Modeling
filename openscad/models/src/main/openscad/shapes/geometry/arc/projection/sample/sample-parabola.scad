
use <../parabola.scad>

zExtrude = 5;

linear_extrude(zExtrude)
parabolaProjection();

translate([0, -25,0])
parabola(zExtrude = 5);

