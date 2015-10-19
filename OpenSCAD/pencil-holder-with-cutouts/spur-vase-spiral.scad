
use <../shapes/cup/cup.scad>;
use <../cutouts/rotated-spiral-cutouts.scad>;

charmCount = 16;
maxRandom = 0;
charmIndcies = rands(0,maxRandom, charmCount);

difference()
{
	cup(cupHeight=150);

	rotatedCutouts(charmIndcies = charmIndcies);
}