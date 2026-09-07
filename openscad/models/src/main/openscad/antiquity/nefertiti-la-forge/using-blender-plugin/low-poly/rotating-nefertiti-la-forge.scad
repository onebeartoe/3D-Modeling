
//use <../nefertiti-la-forge.scad>

t = -$t * 360 * 1;
//t = 0;

//translate([55, -65, 0])
color("lightblue")
rotate ([0, 0, t])
translate([-55, -70, 0])
import("nefertiti-la-forge-using-blender-plugin-touchup.stl");
//import("nefertiti-la-forge-using-blender-plugin-touchup-aligned.stl");
//nefertitiLaForge();

// animation settings:
//    FPS: 20
//    Steps: 80
