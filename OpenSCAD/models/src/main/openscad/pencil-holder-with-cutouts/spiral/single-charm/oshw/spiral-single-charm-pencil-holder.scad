
use <../../../../shapes/cup/cup.scad>;
use <../../../../cutouts/rotated-spiral-cutouts.scad>;

charmCount = 29;
maxRandom = 0;
charmIndcies = rands(0,maxRandom, charmCount);

charmXYScale = 0.4;
charmXYScales = rands(charmXYScale, charmXYScale, charmCount);

depthScale = 20.2;
charmDepthScales = rands(depthScale, depthScale, charmCount);

difference()
{
	cup(cupHeight=150);

	// uses the default value for the charmStls parameter
	rotatedCutouts(charmCount = charmCount,
				   charmIndcies = charmIndcies,
				   charmXYScales = charmXYScales,
				   charmDepthScales = charmDepthScales);
}