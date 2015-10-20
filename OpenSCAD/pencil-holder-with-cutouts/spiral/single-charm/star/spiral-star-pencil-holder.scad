
use <../../../../shapes/cup/cup.scad>;
use <../../../../cutouts/rotated-spiral-cutouts.scad>;

charmCount = 28;
maxRandom = 0;
charmIndcies = rands(0,maxRandom, charmCount);

charmXYScale = 0.9;
charmXYScales = rands(charmXYScale, charmXYScale, charmCount);

depthScale = 40.2;
charmDepthScales = rands(depthScale, depthScale, charmCount);

difference()
{
	cup(cupHeight=150);

	// uses the default value for the charmStls parameter
	rotatedCutouts(charmCount = charmCount,
				   charmIndcies = charmIndcies,
				   charmXYScales = charmXYScales,
				   charmDepthScales = charmDepthScales,
				   charmStls = ["../shapes/star/star.stl"]);
}