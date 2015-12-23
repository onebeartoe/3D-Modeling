
use <../../../shapes/cup/cup.scad>;
use <../../../cutouts/rotated-spiral-cutouts.scad>;

charmCount = 6;
maxRandom = 0;
charmIndcies = rands(0,maxRandom, charmCount);

charmXYScale = 0.8;
charmXYScales = rands(charmXYScale, charmXYScale, charmCount);

depthScale = 20.2;
charmDepthScales = rands(depthScale, depthScale, charmCount);

difference()
{
	cup(cupHeight = 38);
	
	rotatedCutouts(charmCount = 6,
				   charmXYScales = charmXYScales,
				   charmStls = ["../external-resources/oshw/oshw.stl"],
				   charmIndcies = charmIndcies,
				   yTranslateFactor = 0,
				   yTranslateMinimum = 20,
				   zRotationFactor = 360.0 / charmCount,
				   charmDepthScales = charmDepthScales);
}