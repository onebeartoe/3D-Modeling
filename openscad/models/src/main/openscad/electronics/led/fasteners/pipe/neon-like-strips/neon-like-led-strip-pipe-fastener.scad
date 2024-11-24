
use <../../../../../shapes/open-cylinder/open-cylinder.scad>

use <led-strip/led-strip.scad>;
use <clasp/neon-like-strip-clasp.scad>;

module neonLikeLedStripPipeFastener(fastenerHeight = 9,
                                    fastenerThickness = 8,
                                    innerRadius = 33,
                                    ledStripLength = 300,
                                    showLedStrip = false)
{
    difference()
    {
        neonLikeLedStripPipeFastenerSolid(fastenerHeight = fastenerHeight,
                                         fastenerThickness = fastenerThickness,
                                         innerRadius = innerRadius,
                                         ledStripLength = ledStripLength,
                                         showLedStrip = showLedStrip);

        width = 2;
        yTranslate = -width / 2.0;
        translate([0, yTranslate, -0.01])
        cube([100, width, 25]);
    }
}

module neonLikeLedStripPipeFastenerSolid(fastenerHeight,
                                    fastenerThickness,
                                    innerRadius,
                                    ledStripLength,
                                    showLedStrip)
{
    union()
    {
        if(showLedStrip)
        {
            xTranslate = innerRadius + fastenerThickness;
            yTranslate = 0;
            zTranslate = -ledStripLength / 2.0;
            translate([xTranslate, yTranslate, zTranslate])
            neonLikeLedStrip(length = ledStripLength);
        }

        pipeFastener(fastenerThickness = fastenerThickness,
                     height = fastenerHeight,
                     innerRadius = innerRadius
                     );
   
        stipFastener(height = fastenerHeight,
                     fastenerThickness = fastenerThickness,
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
                    height = 10,
                    innerRadius = 1) 
{
    // attacherator
    attacheratorLength_x = 2;
    attacheratorLength_y = neonLikeLedStrip_width() + fastenerThickness + 1;
    attacheratorTranslate_x = fastenerThickness + innerRadius -1;
    attacheratorTranslate_y = -attacheratorLength_y / 2.0;
    color("purple")
    translate([attacheratorTranslate_x, attacheratorTranslate_y, 0])
    cube([attacheratorLength_x, attacheratorLength_y, height]);

    claspThickness = 4;
    xTranslate = innerRadius + fastenerThickness;
    yTranslate = -(neonLikeLedStrip_width() + claspThickness) / 2.0;
    translate([xTranslate, yTranslate, 0])
    stripClasp(claspThickness = claspThickness,
               xLength = height + 8 + 8,
               claspLength = height);
}
