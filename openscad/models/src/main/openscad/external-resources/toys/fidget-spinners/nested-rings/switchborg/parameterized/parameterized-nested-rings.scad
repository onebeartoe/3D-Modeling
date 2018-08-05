
use <../nested-rings.scad>

module stockNestedRings()
{
	outer_radius = stockNestedRings_outerRadius();

	ring_count = stockNestedRings_ringCount();

	nestedRings(outer_radius = outer_radius,
				ring_count = ring_count);
}
