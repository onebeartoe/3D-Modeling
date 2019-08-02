
cubeWithDimensions();

module cubeWithDimensions()
{
    list = computations(5, 6, 7);

    x = list[0];
    y = list[1];
    z = list[2];

    cube([x, y, z]);
}

function computations(a, b, c) = [a+b, b*c, c+1];
