
use <../../power-outltet-cover.scad>

use <../../../../shapes/spurs/spurs-a.scad>


//difference()
{
    union()
    {
        color("white")
        powerOutletCover(1st_plate = "toggle",
                        chargerStand = false);

        spurLogo();
    }

    color("purple")
    rotate([0,0, 90])
    toggle_screws();
}


module spurLogo()
{
    difference()
    {
        color("orange")
        translate([20, 20, -0.10])
        spur(zLength=3.3);

        // color("purple")
        // toggle_screws();
    }
}
