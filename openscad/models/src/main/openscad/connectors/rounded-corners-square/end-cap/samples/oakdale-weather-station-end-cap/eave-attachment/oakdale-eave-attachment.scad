
use <.././../../../../../basics/rounded-edges/rounded-cube/rounded-cube.scad>

cornerRadius = 5;

zLenght = 2;

baseSize = [cornerRadius + 60,  // should be 65
            cornerRadius + 110, // should be 115
            zLenght];

union()
{
    roundedCube(cornerRadius = cornerRadius,
                    sides=20,
                    sidesOnly=true,
                    size=baseSize);

    color("teal")
    tabBar();

    yTranslate = 115 - (baseSize[1] * 0.2);
    color("red")
    translate([0, yTranslate, 0])
    tabBar();
}

module tabBar()
{
    xSize = baseSize[0] + 40;
    ySize = baseSize[1] * 0.2;
    tabSize = [xSize, ySize, zLenght + 0];

    difference()
    {
        xTranslate = baseSize[0] / 2.0 - (xSize / 2.0);

        translate([xTranslate, 0, 0])
        roundedCube(cornerRadius = cornerRadius,
                        sides=20,
                        sidesOnly=true,
                        size=tabSize);


        // cutouts for screws
        cutoutRadius = 2.0;
        cutoutTranslateX = xTranslate * 0.75;
        cutoutTranslateY = ySize / 2.0 - (cutoutRadius / 2.0);

        translate([cutoutTranslateX, cutoutTranslateY, -0.01])
        cylinder(r = cutoutRadius, h = 20);

        otherTranslateX = 77;
        translate([otherTranslateX, cutoutTranslateY, -0.01])
        cylinder(r = cutoutRadius, h = 20);
    }
}

