 
use <../../../basics/rounded-edges/rounded-cube/rounded-cube.scad>

boardLength = 150;
boardWidth = 100;
size = [boardLength, boardWidth, 1];

roundedCube(cornerRadius = 5,
            sides=20,
            sidesOnly=true,
            size=size);

