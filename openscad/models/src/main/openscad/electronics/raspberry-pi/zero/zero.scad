
use <../../../basics/rounded-edges/rounded-cube/rounded-cube.scad>

/**
 *  This is the primary module of this file.
 */
module raspberryPiZero()
{
    xLength = 65;
    yLength = 30;

    difference()
    {
        raspberryPiZero_board(xLength, yLength);

        raspberryPiZero_mountingHoles(xLength, yLength);
    }
}

//////////////////////////////////////////////////
// support modules and functions follow

module raspberryPiZero_board(xLength, yLength)
{
    size = [xLength, yLength, 1];


    // printed circuit board
    color("green")
    cube(size);
}

module raspberryPiZero_mountingHoles(xLength, yLength)
{

}
