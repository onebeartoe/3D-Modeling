
use <../../faceplate/letters-symbols-faceplate.scad>

use <../../../../../shapes/geometry/arc/projection/parabola.scad>


//lettersSymbolsFaceplate();

sidePlate();

module sidePlate()
{
    difference()
    {
//        linear_extrude(0.1)
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
//    }

    color("red")
    translate([0, 1, 1])
    rotate([0, -90, 0])
    scale([1,1,1])
    sidePlateCutout();
}    
}


module sidePlateCutout()
{
    difference()
    {
        d1 = 120;
        h = 115;
        linear_extrude(1)
        parabola(d1 = d1,
                h = h);

        linear_extrude(4)
        translate([-1,0,0])
        parabola(d1 = d1,
                h = h);

        cutoutLengthX = 5;
        cutoutLengthY = 65;
        cutoutTranslateX = -cutoutLengthX / 2.0;
        cutoutTranslateY = -cutoutLengthY;
        color("black")
        rotate([0, 90, 0])
        translate([cutoutTranslateX, cutoutTranslateY, 0])
        cube(size = [cutoutLengthX, cutoutLengthY, 145]);
//        parabola();    
    }    
}
