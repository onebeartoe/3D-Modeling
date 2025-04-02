
use <../../../shapes/minecraft/copper-golem/copper-golem.scad>

scale = $t * 1;

scale([scale, scale, scale])
rotate ([0, 0, $t*360])
copperGolem();


// animation settings:
//    FPS: 20
//    Steps: 100

