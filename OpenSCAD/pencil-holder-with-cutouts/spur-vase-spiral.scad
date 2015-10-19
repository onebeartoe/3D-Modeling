
use <../shapes/cup/cup.scad>;
use <../cutouts/rotated-spiral-cutouts.scad>;

difference()
{
	cup(cupHeight=150);

	rotatedCutouts();
}