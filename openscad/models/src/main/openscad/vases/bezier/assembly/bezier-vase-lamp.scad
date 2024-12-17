
use <../bezier-vase.scad>

use <../shade/lampshade.scad>

zTranslate = 200;

translate([0, 0, zTranslate])
bezierLampshade();

color("blue")
bezierVase(t_step = 0.02);