
use <../bezier-vase.scad>

use <../shade/lampshade.scad>

zTranslate = 200;

translate([0, 0, zTranslate])
bezierLampshade();

//color("red")
//bezierVase(t_step = 0.05);
//bezierVase(t_step = 0.031);
bezierVase(t_step = 0.02);