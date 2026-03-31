
use <../neon-like-strips/neon-like-led-strip-pipe-fastener.scad>

/*

House of Manny

	frame outer diameter

		22mm

        but to accomodate the blankets/tarps the outter diameter needs to be 26mm

    frame inner diameter

        15mm

*/

desiredOuterDiameter = 23; // 26 was too loose;
desiredInnerDiameter = 15;
fastenerThickness = 3;

innerRadius = desiredOuterDiameter / 2.0 + fastenerThickness;


neonLikeLedStripPipeFastener(fastenerHeight = 9,
                             fastenerThickness = fastenerThickness,
                             innerRadius = innerRadius,
                             ledStripLength = 50);
