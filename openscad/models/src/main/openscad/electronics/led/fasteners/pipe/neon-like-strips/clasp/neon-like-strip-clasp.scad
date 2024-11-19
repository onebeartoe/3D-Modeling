
use <../led-strip/led-strip.scad>;

module stripClasp(claspThickness = 4,
                  claspLength = 15)
{
    claspWidth = neonLikeLedStrip_width() + claspThickness;

    claspHeight = neonLikeLedStrip_height() + claspThickness;    
 
    union()
    {
        stripClasp_main(claspHeight = claspHeight,
                        claspLength = claspLength,
                        claspThickness = claspThickness,
                        claspWidth = claspWidth
                        );

        stripClasp_screwHolder();
    }
} 

module stripClasp_main(claspHeight,
                        claspLength,
                        claspThickness,
                        claspWidth)
{
    difference()
    {
        cube([claspHeight, claspWidth, claspLength ]);
 
        zTranslate = (claspHeight / 2.0) - (neonLikeLedStrip_height() / 2.0);
        yTranslate = (claspLength / 2.0) - (neonLikeLedStrip_width() / 2.0);
        translate([-1, yTranslate, zTranslate])
        cube([20, neonLikeLedStrip_width(), neonLikeLedStrip_height()]);
    }
}
 
module stripClasp_screwHolder()
{
    echo("fartooooo");
}
