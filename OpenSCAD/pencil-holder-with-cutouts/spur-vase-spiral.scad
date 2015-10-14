
use <../shapes/cup/cup.scad>;
use <../cutouts/rotated-spiral-cutouts.scad>;

cupHeight = 150;

difference()
{
	cup(cupHeight=cupHeight);

	propossedRotatedSpiralCutout();
}