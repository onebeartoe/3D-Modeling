
use <../../pencil-holder.scad>;
use <../../../cutouts/rotated-spiral-cutouts.scad>;

difference()
{
	cup();

	rotatedSpiralCutout();
}