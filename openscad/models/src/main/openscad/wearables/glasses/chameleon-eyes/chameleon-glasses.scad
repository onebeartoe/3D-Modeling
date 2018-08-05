
use <../../../external-resources/toys/fidget-spinners/nested-rings/switchborg/nested-rings.scad>
use <../../../external-resources/toys/fidget-spinners/nested-rings/switchborg/parameterized/parameterized-nested-rings.scad>

module chameleonGlasses()
{

    stockNestedRings();

	outer_radius = stockNestedRings_outerRadius();

	step = stockNestedRings_step();

	ring_count = stockNestedRings_ringCount();

	xTranslate = outer_radius +
				 (stockNestedRings_biconeGap() + step) * ring_count;

    translate([xTranslate,0,0])
    stockNestedRings();
}
