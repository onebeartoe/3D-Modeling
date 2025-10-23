
use <../assembled/assembled-sign.scad>

controlPanelSidePlate();

module controlPanelSidePlate()
{
    difference()
    {
        sidePlate();


//TODO: use trinket cutout from here: 
//          microcontrollers/adafruit/pro-trinket/faceplate/pro-trinket-faceplate.scad
        trinketCutout();

        potentiometerCutout();

        switchCutout();
    }
}

//TODO: use trinket cutout from here: 
//          microcontrollers/adafruit/pro-trinket/faceplate/pro-trinket-faceplate.scad
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
    cube([10, 2.6, 15.5]);

//    color("pink")
    color("purple")
    translate([-4, 10.5, 30.4])
    cube([10, 3.42, 8.2]);
}

module potentiometerCutout()
{
    xyLenght = 10.0;

    color("blue")
    translate([-4, 25.0, 25.0])
    cube([10, xyLenght, xyLenght]);
}

module switchCutout()
{
    color("black")
    translate([-4, 7.0, 7.0])
    cube([10, 14.5, 10.0]);
}
