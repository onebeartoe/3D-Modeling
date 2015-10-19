
use <../../../shapes/cup/cup.scad>;
use <../../../cutouts/rotated-spiral-cutouts.scad>;

charmCount = 6;

difference()
{
	cup();
	
	rotatedCutouts(charmCount = 6,
								 xyScale = 0.125,
								 charmStl = "../../../shapes/spurs/spurs-a.stl",
								 yTranslateFactor = 0,
								 yTranslateMinimum = 35,
								 zRotationFactor = 360.0 / charmCount);
}