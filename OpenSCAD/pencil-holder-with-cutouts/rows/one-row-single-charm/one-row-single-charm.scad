
use <../../../shapes/cup/cup.scad>;
use <../../../cutouts/rotated-spiral-cutouts.scad>;

charmCount = 6;
maxRandom = 0;
charmIndcies = rands(0,maxRandom, charmCount);

charmXYScale = 0.125;
charmXYScales = rands(charmXYScale, charmXYScale, charmCount);

depthScale = 20.2;
charmDepthScales = rands(depthScale, depthScale, charmCount);

difference()
{
	cup();
	
	rotatedCutouts(charmCount = 6,
								 charmXYScales = charmXYScales,
								 charmStls = ["../../../shapes/spurs/spurs-a.stl"],
								 charmIndcies = charmIndcies,
								 yTranslateFactor = 0,
								 yTranslateMinimum = 35,
								 zRotationFactor = 360.0 / charmCount,
				   charmDepthScales = charmDepthScales);
}