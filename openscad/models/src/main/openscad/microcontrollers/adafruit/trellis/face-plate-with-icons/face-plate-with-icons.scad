
use <../../../../basics/rounded-edges/rounded-cube/rounded-cube.scad>

module facePlateWithIcons(boardWidth = 77)
{
//    difference()
    {
//        import("/Users/lando/Versioning/world/betoland-world/electronics/adafruit/trellis/Trellis_Soundboard/sfxb-top.stl");

        facePlateWithIcons_centerTile(boardWidth = boardWidth);
    }
}

module facePlateWithIcons_centerTile(boardWidth)
{
    difference()
    {
        color("green")

        translate([0, 0, 0.5])
        roundedCube(cubeCentered = true,
                    size = [boardWidth, boardWidth, 1],
                    sidesOnly = true);

        spacing = 31.1;
//        color("green")
        translate([spacing, spacing, 0])
        facePlateWithIcons_centerTile_cutouts();
    }
}

module facePlateWithIcons_centerTile_cutouts()
{
    boardWidth = 6.3;

    step = 1;

    yStart = 1;
    yEnd = 4;

    zStart = 1;
    zEnd = 4;

    for(x = [yStart : step : yEnd],
    	y = [zStart : step : zEnd])
    {
    	separateor = " - ";

        spacing = 15;

        xTranslate = boardWidth + (-x * spacing);

        yTranslate = boardWidth + (-y * spacing);

        echo(xTranslate, separateor, yTranslate);

        translate([xTranslate, yTranslate, 0.5])
//        translate([xTranslate, yTranslate, 1 * x])
        roundedCube(cubeCentered = true,
                    size = [boardWidth, boardWidth, 5],
                    sidesOnly = true);
    }
}
