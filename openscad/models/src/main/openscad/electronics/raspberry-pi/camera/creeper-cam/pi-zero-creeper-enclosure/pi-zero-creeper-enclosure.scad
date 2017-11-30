
use <../../../../../external-resources/electronics/single-board-computers/raspberry-pi/zero/camera/encosure/T_Hambush/campicase.scad>


module piZeroCreeperEnclosure()
{
    difference()
    {
        campicase();


        cutoutLengthX = 18;
        enclosureLengthX = 40;
        xTranslate = -enclosureLengthX / 2.0 + cutoutLengthX / 2.0;
        color("black")
        translate([0, 04, 1])
        cube(size = [cutoutLengthX, 10, 4],
             center = true);
    }
}
