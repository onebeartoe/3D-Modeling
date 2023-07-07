
include <../../power-outltet-cover.scad>

use <../../../../shapes/spurs/spurs-a.scad>


difference()
{
    union()
    {
        color("white")
        powerOutletCover(1st_plate = "toggle",
                        chargerStand = false);

        spurLogo();
    }

    yTranslate =  -57.2;
    color("purple")
    translate([0, yTranslate, 0])
    rotate([0,0, 90])
    toggle_screws();

    // lever cutout
//    translate([height_sizes[plate_size]/2,0,0]) 
rotate([0,0, 90])
    cube([23.8125,10.3188,25], center = true);
}


module spurLogo()
{
    difference()
    {
//        color("orange")
        color("black")
        translate([26, 41, -0.10])
        spur(zLength=4);
    }
}
