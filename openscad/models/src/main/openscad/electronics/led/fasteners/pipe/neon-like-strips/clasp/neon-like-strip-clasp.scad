
use <../led-strip/led-strip.scad>;

module stripClasp(claspThickness = 4,
                  xLength = 88,
                  claspLength = 15)
{
    claspWidth = neonLikeLedStrip_width() + claspThickness; 
 
    union()
    {
        color("lime")
        stripClasp_main(xLength = xLength,
                        claspLength = claspLength,
                        claspThickness = claspThickness,
                        claspWidth = claspWidth
                        );

        stripClasp_screwHolder();
    }
} 

module stripClasp_main(xLength,
                        claspLength,
                        claspThickness,
                        claspWidth)
{
    difference()
    {
        cube([xLength, claspWidth, claspLength ]);
 
        yTranslate = neonLikeLedStrip_width() / 2.0 - 1;
        xTranslate = 2;
        translate([xTranslate, yTranslate, -0.01])
        neonLikeLedStrip(length = 20);
    }
}
 
module stripClasp_screwHolder()
{
    echo("fartooooo");
}
