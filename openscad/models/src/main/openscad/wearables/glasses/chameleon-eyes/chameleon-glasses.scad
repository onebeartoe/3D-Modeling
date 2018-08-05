
use <../../../external-resources/toys/fidget-spinners/nested-rings/switchborg/nested-rings.scad>



module chameleonGlasses()
{
    nestedRings();

    xTranslate =  outer_radius + step * ring_count;
    xTranslate = 33;

    translate([xTranslate,0,0])
    nestedRings();
}
