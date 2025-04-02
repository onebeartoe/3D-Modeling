

use <../../../shapes/minecraft/copper-golem/copper-golem.scad>


rotate ([0, 0, $t*360])

translate ([9, 0])

rotate ([0, 0, -$t*360])

// square(5, center=true);
copperGolem();
