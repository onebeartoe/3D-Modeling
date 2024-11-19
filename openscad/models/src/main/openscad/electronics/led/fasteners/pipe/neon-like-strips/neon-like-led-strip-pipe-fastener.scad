
use <../../../../../shapes/open-cylinder/open-cylinder.scad>

use <led-strip/led-strip.scad>;
use <clasp/neon-like-strip-clasp.scad>;

module neonLikeLedStripPipeFastener(fastenerThickness = 8,
                                    innerRadius = 33,
                                    ledStripLength = 300,
                                    showLedStrip = false)
{
    union()
    {
        if(showLedStrip)
        {
            zTranslate = -ledStripLength / 2.0;
            translate([0,0,zTranslate])
            neonLikeLedStrip(length = ledStripLength);
        }

        pipeFastener(fastenerThickness = fastenerThickness,
                                    innerRadius = innerRadius
                                    );
   
        stipFastener(fastenerThickness = fastenerThickness,
                                    innerRadius = innerRadius);
    }
}

module pipeFastener(fastenerThickness = 5,
                    height = 9,
                    innerRadius = 10)
{
    outerRadius = innerRadius + fastenerThickness;

    openCylinder(height = height,
                innerRadius = innerRadius,
                outerRadius = outerRadius);
}

module stipFastener(fastenerThickness = 2,
                                    innerRadius = 1) 
{
    // attacherator
//    cube([]);

    xTranslate = innerRadius + fastenerThickness;
    yTranslate = 0;
    translate([xTranslate, 0, 0])
    stripClasp();
}