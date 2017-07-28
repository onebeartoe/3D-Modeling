
use <../../rounded-cube.scad>
        
boardLength = 150;
boardWidth = 100;

roundedCube([boardLength, boardWidth, 1], 5, sides=20);

translate([0, 130, 0])
roundedCube([boardLength, boardWidth, 1], 5, sides=20, sidesOnly=true);
