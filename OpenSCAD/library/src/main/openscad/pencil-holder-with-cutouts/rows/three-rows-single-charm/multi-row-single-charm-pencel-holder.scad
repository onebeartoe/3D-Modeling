
use <../../../shapes/cup/cup.scad>;
use <../../../cutouts/rotated-spiral-cutouts.scad>;

charmStl = "../shapes/blue-moon/blue-moon.stl";

charmCount = 10;
maxRandom = 0;
charmIndcies = rands(0,maxRandom, charmCount);

charmScale = 0.9;
charmScales = rands(charmScale, charmScale, charmCount);

rowSpacing = 36;

depthScale = 20.2;
charmDepthScales = rands(depthScale, depthScale, charmCount);

difference()
{
    cup(cupHeight=140, innerRadius=50);
	
	for(r = [1 : 3]) // create 3 rows of charms
	{
		rotate ([0, 0, r * 20])  /// this offsets the rows a little so that they are not lined up vertically
		rotatedCutouts(charmCount = charmCount,
									 zRotationFactor = 360 / charmCount,
									 yTranslateFactor = 0,
									 yTranslateMinimum = r * rowSpacing,
 									 charmStls = [charmStl],
									 charmIndcies = charmIndcies,
									 charmXYScales = charmScales,
									 charmDepthScales = charmDepthScales);
	}
}

