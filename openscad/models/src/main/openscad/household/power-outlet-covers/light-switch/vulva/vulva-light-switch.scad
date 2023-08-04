
include <../../power-outltet-cover.scad>

difference()
{
    union()
    {
        color("white")
        powerOutletCover(1st_plate = "toggle",
                        chargerStand = false);


        xyScale = 1.5;
        scale([xyScale, xyScale, 1])
        translate([115, -35, -24])
        rotate([-60, 0, 0])
        vulva();
    }

    yTranslate =  -57.2;
    color("purple")
    scale([1, 1, 1.5])
    translate([0, yTranslate, 0])
    rotate([0,0, 90])
    toggle_screws();

    // lever cutout
    translate([0,0,0]) 
    rotate([0,0, 90])
    cube([23.8125, 10.3188, 45], center = true);

    zLength = 20;
    translate([110, 0, -zLength/2.0])
    cube([400, 400, 20], center=true);
}


module vulva()
{
    stlPath = "/home/roberto/Versioning/world/beto-land-world/household/outlet-plates/vulva-light-switch/DesignTime/Vulva1b.stl";

    import(stlPath, convexity=10);
}
