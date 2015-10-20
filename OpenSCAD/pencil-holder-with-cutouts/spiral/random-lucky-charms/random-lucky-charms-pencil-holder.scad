
use <../../../shapes/cup/cup.scad>;
use <../../../cutouts/rotated-spiral-cutouts.scad>;

// this determines how tall the pen holder is
cupHeight = 300;

// this sets how many cutouts are in the pen holder
charmCount = 35;

spursCharmStl = "../shapes/spurs/spurs-a.stl";
spursCharmXYScale = 0.2;  // spur scale
spursCharmDepthScale = 20.2;   // oshw depth scale

oshwCharmStl = "../shapes/oshw/oshw.stl";
oshwCharmXYScale = 0.7;
oshwCharmDepthScale = 40.2;

starCharmStl = "../shapes/star/star.stl";
starCharmXYScale = 0.7;
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

maxRandom = len(charmStls) - 1;

randomSeed = 2789676;

//	randomSeed = rands(0,987654, 1)[0];         // uncomment this line to have a different pattern each time the model is rendered by OpenSCAD.	

randomCharmIndcies = rands(0,maxRandom, charmCount, randomSeed);

difference()
{
	cup(cupHeight);
	
	rotatedCutouts(charmCount = charmCount,
	               charmStls = charmStls,
	               charmIndcies = randomCharmIndcies,
				   charmXYScales = charmXYScales,
				   charmDepthScales = charmDepthScales,
				   zRotationFactor = 38);
}