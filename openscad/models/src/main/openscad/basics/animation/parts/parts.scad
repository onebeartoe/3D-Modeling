

use <../../../shapes/minecraft/copper-golem/copper-golem.scad>

// rotate ([0, 0, $t*360])

//translate ([10, 0])

// square(5, center=true);
copperGolem(headRotation_z = $t*360,
            rightArmRotation_x = $t*360);



// animation settings:
//    FPS: 20
//    Steps: 35