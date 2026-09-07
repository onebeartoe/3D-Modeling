
use <../nefertiti-la-forge.scad>

t = -$t * 360 * 2;
//t = 0;

translate([55, -65, 0])
rotate ([0, 0, t])
import("nefertiti-la-forge.stl");
//nefertitiLaForge();

// animation settings:
//    FPS: 20
//    Steps: 100


