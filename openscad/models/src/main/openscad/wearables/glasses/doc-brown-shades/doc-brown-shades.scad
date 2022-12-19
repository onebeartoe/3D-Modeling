

use <../../../external-resources/toys/fidget-spinners/nested-rings/switchborg/nested-rings.scad>

use <../chameleon-eyes/chameleon-glasses.scad>

xTranslate = -(stockNestedRings_outerRadius() * 1 + 12.5);

translate([xTranslate,0,0])
chameleonGlasses();
