
use <../shapes/cup/cup.scad>;
use <../cutouts/rotated-spiral-cutouts.scad>;

spurStl = "../shapes/spurs/spurs-a.stl";

littleSpurCount = 10;

spurScale = 0.125;

rowSpacing = 36;

difference()
{
    cup(cupHeight=140, innerRadius=50);
	
	for(r = [1 : 3])
	{
		propossedRotatedSpiralCutout(charmCount = littleSpurCount,
									 zRotationFactor = 360 / littleSpurCount,// + 1,
									 yTranslateFactor = 0,//r*rowSpacing,//0,
									 yTranslateMinimum = r * rowSpacing,//15,//r * 35,
 									 charmStl = spurStl,
									 xyScale = spurScale);
	}
}