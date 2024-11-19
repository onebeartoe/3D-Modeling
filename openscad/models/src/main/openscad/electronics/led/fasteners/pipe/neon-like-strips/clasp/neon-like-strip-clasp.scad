
use <../led-strip/led-strip.scad>;

claspThickness = 4;

claspWidth = neonLikeLedStrip_width() + claspThickness;

claspLength = 15;

claspHeight = neonLikeLedStrip_height() + claspThickness;

module stripClasp()
{
    union()
    {
        stripClasp_main();

        stripClasp_screwHolder();
    }
}

module stripClasp_main()
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

}
