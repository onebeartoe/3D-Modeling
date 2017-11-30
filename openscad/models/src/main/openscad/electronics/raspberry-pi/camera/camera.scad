
use <../../../basics/rounded-edges/rounded-cube/rounded-cube.scad>

/**
 *  This is the primary module of this file.
 */
module raspberryPiCamera()
{
    xLength = 25;
    yLength = 24;


    difference()
    {
        raspberryPiCamera_boardAndCamera(xLength, yLength);

        raspberryPiCamera_mountingHoles(xLength, yLength);
    }
}

//////////////////////////////////////////////////
// support modules and functions follow

module raspberryPiCamera_boardAndCamera(xLength, yLength)
{
    size = [xLength, yLength, 1];
    union()
    {
        // printed circuit board
        color("green")
        cube(size);

        // lense box
        color("black")
        translate([8.5,5.5,0])
        cube([8, 8, 5]);
    }
}

module raspberryPiCamera_mountingHoles(xLength, yLength)
{
    union()
    {
        // bottom left
        color("orange")
        translate([2, 9.5,-0.01])
        cylinder(r=1,
                 h=3,
                 $fn=30);

        // bottom right
        translate([xLength-2, 9.5, -0.01])
        cylinder(r=1,
                  h=3,
                  $fn=30);

        // top left
        translate([2, yLength-2,-0.01])
        cylinder(r=1,
                 h=3,
                 $fn=30);

        // top right
        translate([xLength-2, yLength-2,-0.01])
        cylinder(r=1,
                h=3,
                $fn=30);
    }
}
