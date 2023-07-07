
use <../../power-outltet-cover.scad>

use <../../../../shapes/spurs/spurs-a.scad>

union()
{
    color("white")
    powerOutletCover(1st_plate = "toggle",
                    chargerStand = false);

    spurLogo();
}

module spurLogo()
{
    color("orange")
    translate([20, 20, -0.10])
    spur(zLength=3);
}