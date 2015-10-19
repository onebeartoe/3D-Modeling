
use <../shapes/cup/cup.scad>;
use <../cutouts/rotated-spiral-cutouts.scad>;

charmCount = 16;
maxRandom = 0;
charmIndcies = rands(0,maxRandom, charmCount);

charmXYScales = rands(0.4, 0.4, charmCount);

depthScale = 20.2;
charmDepthScales = rands(depthScale, depthScale, charmCount);

difference()
{
	cup(cupHeight=150);

	rotatedCutouts(charmIndcies = charmIndcies,
				   charmXYScales = charmXYScales,
				   charmDepthScales = charmDepthScales);
}