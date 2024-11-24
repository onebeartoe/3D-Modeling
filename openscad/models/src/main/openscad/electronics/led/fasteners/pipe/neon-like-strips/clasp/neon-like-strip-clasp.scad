
use <../led-strip/led-strip.scad>;

module stripClasp(claspThickness = 4,
                  claspLength = 15)
{
    claspWidth = neonLikeLedStrip_width() + claspThickness;

    claspHeight = neonLikeLedStrip_height() + claspThickness;    
 
    union()
    {
        color("lime")
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
