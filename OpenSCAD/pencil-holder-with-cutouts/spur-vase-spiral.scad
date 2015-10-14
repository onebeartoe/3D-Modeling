
use <../shapes/cup/cup.scad>;
use <../cutouts/rotated-spiral-cutouts.scad>;

vaseHeight = 150;

difference()
{
	cup(cupHeight=vaseHeight);

	propossedRotatedSpiralCutout();
}