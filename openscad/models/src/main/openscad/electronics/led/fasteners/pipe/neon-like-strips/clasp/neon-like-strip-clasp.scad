
use <../led-strip/led-strip.scad>;

module stripClasp(claspThickness = 4,
                  xLength = 88,
                  claspLength = 15)
{
    claspWidth = neonLikeLedStrip_width() + claspThickness; 
 
    union()
    {
        stripClasp_main(xLength = xLength,
                        claspLength = claspLength,
                        claspThickness = claspThickness,
                        claspWidth = claspWidth
                        );

//        stripClasp_screwHolder();
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
        color("lime")
        translate([xTranslate, yTranslate, -0.01])
        neonLikeLedStrip(length = 20);

        stripClasp_screwHolder(claspLength = claspLength,
                               xLength = xLength);
    }
}
 
module stripClasp_screwHolder(claspLength, xLength)
{
    // bolt recess x2
    boltRecesRadius = 3;
    xTranslate = xLength - 5;
    yTranslate = claspLength / 2.0 ;
    zTranslate = -2;  //-15;    
    rotate([90,0,0])
    translate([xTranslate, yTranslate, zTranslate])
    color("blue")
    cylinder(r=boltRecesRadius, h=5, $fn = 6);

    zTranslate_second = -claspLength  - 4;
    rotate([90,0,0])
    translate([xTranslate, yTranslate, zTranslate_second])
    color("grey")
    cylinder(r=boltRecesRadius, h=5, $fn = 6);


    // bolt hole
    rotate([90,0,0])
    translate([xTranslate, yTranslate, zTranslate_second])
    color("green")
    cylinder(r=1, h=15, $fn = 20);


    echo("fartooooo");
}
