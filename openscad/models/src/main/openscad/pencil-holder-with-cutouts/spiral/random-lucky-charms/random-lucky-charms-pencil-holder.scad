use <../../../shapes/cup/cup.scad>;
use <../../../cutouts/rotated-spiral-cutouts.scad>;

// this determines how tall the pen holder is
cupHeight = 150;

// this sets how many cutouts are in the pen holder
charmCount = 27;

heartCharmStl = "../shapes/heart/heart.stl";
heartCharmXYScale = 0.5;
heartCharmDepthScale = 40.2;   

horseshoeCharmStl = "../shapes/horseshoe/horseshoe.stl";
horseshoeCharmXYScale = 0.375;
horseshoeCharmDepthScale = 40.2;

starCharmStl = "../shapes/star/star.stl";
starCharmXYScale = 0.7;
starCharmDepthScale = 40.2;

blueMoonCharmStl = "../shapes/blue-moon/blue-moon.stl";
blueMoonCharmXYScale = 0.9;
blueMoonCharmDepthScale = 40.0;

balloonCharmStl = "../shapes/balloon/balloon.stl";
balloonCharmXYScale = 0.9;
balloonCharmDepthScale = 40.0;

hourglassCharmStl = "../shapes/hourglass/hourglass.stl";
hourglassCharmXYScale = 0.2;
hourglassCharmDepthScale = 40.0;

charmStls = [
                heartCharmStl,
                horseshoeCharmStl,
                starCharmStl,
				blueMoonCharmStl,
				balloonCharmStl,
				hourglassCharmStl
            ];

charmXYScales = [
                    heartCharmXYScale,
                    horseshoeCharmXYScale,
                    starCharmXYScale,
					blueMoonCharmXYScale,
					balloonCharmXYScale,
					hourglassCharmXYScale
                ];
                
charmDepthScales = [
                        heartCharmDepthScale,
                        horseshoeCharmDepthScale,
                        starCharmDepthScale,
						blueMoonCharmDepthScale,
						balloonCharmDepthScale,
						hourglassCharmDepthScale
                   ];

maxRandom = len(charmStls) - 1;

randomSeed = 1597538;

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

