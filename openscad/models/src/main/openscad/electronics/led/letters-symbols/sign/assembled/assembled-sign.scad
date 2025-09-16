
use <../../faceplate/letters-symbols-faceplate.scad>

use <../../../../../shapes/geometry/arc/projection/parabola.scad>


lettersSymbolsFaceplate();

sidePlate();

module sidePlate()
{
    difference()
    {
        rotate([0, -90, 0])
        parabola(d1 = 127,
                h = 120);

        cubeLengthX = 5;
        cubeLengthY = 70;
        cubeTranslateX = -cubeLengthX / 2.0;
        cubeTranslateY = -cubeLengthY;
        color("purple")
        translate([cubeTranslateX, cubeTranslateY, 0])
        cube(size = [cubeLengthX, cubeLengthY, 150]);                
    }

    color("red")
    rotate([0, -90, 0])
    sidePlateCutout();
}


module sidePlateCutout()
{
    difference()
    {
//        linear_extrude(5)
            parabola();

            translate([-1,0,0])
            parabola();

    //           parabola();
    }    
}
