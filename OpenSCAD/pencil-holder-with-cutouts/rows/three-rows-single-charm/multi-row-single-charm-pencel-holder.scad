
use <../shapes/cup/cup.scad>;
use <../cutouts/rotated-spiral-cutouts.scad>;

spurStl = "../shapes/spurs/spurs-a.stl";

littleSpurCount = 10;
maxRandom = 0;
charmIndcies = rands(0,maxRandom, littleSpurCount);

spurScale = 0.125;
spurScales = rands(spurScale, spurScale, littleSpurCount);

rowSpacing = 36;

depthScale = 20.2;
charmDepthScales = rands(depthScale, depthScale, littleSpurCount);

difference()
{
    cup(cupHeight=140, innerRadius=50);
	
	for(r = [1 : 3]) // create 3 rows of charms
	{
		rotate ([0, 0, r * 30])  /// this offsets the rows a little so that they are not lined up vertically
		rotatedCutouts(charmCount = littleSpurCount,
									 zRotationFactor = 360 / littleSpurCount,
									 yTranslateFactor = 0,
									 yTranslateMinimum = r * rowSpacing,
 									 charmStls = [spurStl],
									 charmIndcies = charmIndcies,
									 charmXYScales = spurScales,
									 charmDepthScales = charmDepthScales);
	}
}