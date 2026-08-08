
use <../../rounded-cube.scad>

boardLength = 150;
boardWidth = 100;

// near default example
roundedCube(size=[boardLength, boardWidth, 1],
            sides=20);

// another example of a rounded cube with a different corner radius and color
size = [boardLength, boardWidth, 1];
color("green")
translate([0, 130, 0])
roundedCube(cornerRadius = 5,
            sides=20,
            sidesOnly=true,
            size=size);
