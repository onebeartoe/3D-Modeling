
use <../../../../shapes/cup/cup.scad>;
use <../../../../cutouts/rotated-spiral-cutouts.scad>;

// this determines how tall the pen holder is
cupHeight = 150;

// this sets how many cutouts are in the pen holder
charmCount = 28;

spursCharmStl = "../shapes/football/Football_v2.stl";
spursCharmXYScale = 0.18;
spursCharmDepthScale = 20.2;

oshwCharmStl = "../shapes/texas/texas.stl";
oshwCharmXYScale = 0.09;
oshwCharmDepthScale = 40.2;

starCharmStl = "../shapes/star/star.stl";
starCharmXYScale = 0.9;
starCharmDepthScale = 40.2;

charmStls = [
                spursCharmStl,
                oshwCharmStl,
                starCharmStl
            ];

charmXYScales = [
                    spursCharmXYScale,
                    oshwCharmXYScale,
                    starCharmXYScale
                ];
                
charmDepthScales = [
                        spursCharmDepthScale,
                        oshwCharmDepthScale,
                        starCharmDepthScale
                   ];

charmPatternIndcies = [0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2];

difference()
{
	cup(cupHeight);
	
	rotatedCutouts(charmCount = charmCount,
	               charmStls = charmStls,
	               charmIndcies = charmPatternIndcies,
				   charmXYScales = charmXYScales,
				   charmDepthScales = charmDepthScales,
				   zRotationFactor = 38);
}