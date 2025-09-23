
use <../assembled/assembled-sign.scad>

controlPanelSidePlate();

module controlPanelSidePlate()
{
    difference()
    {
        sidePlate();

        trinketCutout();

        potentiometerCutout();

        switchCutout();
    }
}

module trinketCutout()
{
    // this needs to be 8mm off of the wooden platform
    zTranslate = 8;

    //  and centered on the horizontal plane
    color("purple")
    translate([34, 8, 34])
    rotate([0, 90, 90])
    import("/home/luke/Distribute/world/adafruit/pro-trinket/2010-ProTrinket-3V.3mf");

//    color("green")
    color("purple")
    translate([-4, 8, 26.9])
    cube([10, 1.6, 14.5]);

//    color("pink")
    color("purple")
    translate([-4, 9.5, 30.4])
    cube([10, 2.42, 7.2]);
}

module potentiometerCutout()
{
    xyLenght = 9.5;

    color("blue")
    translate([-4, 25.0, 25.0])
    cube([10, xyLenght, xyLenght]);
}

module switchCutout()
{
    color("black")
    translate([-4, 7.0, 7.0])
    cube([10, 13.0, 9.0]);
}
