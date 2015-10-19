
use <../../../shapes/cup/cup.scad>;
use <../../../cutouts/rotated-spiral-cutouts.scad>;

charmCount = 6;
maxRandom = 0;
charmIndcies = rands(0,maxRandom, charmCount);

difference()
{
	cup();
	
	rotatedCutouts(charmCount = 6,
								 charmXYScale = 0.125,
								 charmStls = ["../../../shapes/spurs/spurs-a.stl"],
								 charmIndcies = charmIndcies,
								 yTranslateFactor = 0,
								 yTranslateMinimum = 35,
								 zRotationFactor = 360.0 / charmCount);
}