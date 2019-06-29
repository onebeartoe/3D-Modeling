
use <../../../../basics/rounded-edges/rounded-cube/rounded-cube.scad>

module facePlateWithIcons(boardWidth = 77,
                          leftTileOn = "No",
                          plateHeight = 1)
{
//    difference()
    {
//        import ("/home/roberto/Versioning/world/betoland/electronics/adafruit/trellis/Trellis_Soundboard/sfxb-top.stl");
//        import("/Users/lando/Versioning/world/betoland-world/electronics/adafruit/trellis/Trellis_Soundboard/sfxb-top.stl");

        union()
        {
            if(leftTileOn == "Yes")
            {
                smidgend = 1;

                xTranslate = -boardWidth * 1.5 - 1;
                yTranslate = -boardWidth / 2.0 + smidgend;
                translate([xTranslate, yTranslate, 0])
                facePlateWithIcons_leftTile(boardWidth = boardWidth,
                                            plateHeight = plateHeight);
            }

            facePlateWithIcons_centerTile(boardWidth = boardWidth, plateHeight = plateHeight);


        }
    }
}

module facePlateWithIcons_centerTile(boardWidth, plateHeight)
{
    difference()
    {
        color("green")

        translate([0, 0, 0.5])
        roundedCube(cubeCentered = true,
                    size = [boardWidth, boardWidth, plateHeight],
                    sidesOnly = true);

        spacing = 31.1;

        translate([spacing, spacing, 0])
        facePlateWithIcons_centerTile_cutouts_buttons();

        facePlateWithIcons_centerTile_cutouts_screws();
    }
}

module facePlateWithIcons_centerTile_cutouts_buttons()
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
        spacing = 15;

        xTranslate = boardWidth + (-x * spacing);

        yTranslate = boardWidth + (-y * spacing);

//        separateor = " - ";
//        echo(xTranslate, separateor, yTranslate);

        translate([xTranslate, yTranslate, 0.5])
        roundedCube(cubeCentered = true,
                    size = [boardWidth, boardWidth, 5],
                    sidesOnly = true);
    }
}

module facePlateWithIcons_centerTile_cutouts_screws()
{
    radius = 2;
    translateXY = 35;

    translate([translateXY, translateXY, 0])
    cylinder(r=radius, h=30, center=true, $fn = 20);

    translate([translateXY, -translateXY, 0])
    cylinder(r=radius, h=30, center=true, $fn = 20);

    translate([-translateXY, translateXY, 0])
    cylinder(r=radius, h=30, center=true, $fn = 20);

    translate([-translateXY, -translateXY, 0])
    cylinder(r=radius, h=30, center=true, $fn = 20);
}

module facePlateWithIcons_leftTile(boardWidth, plateHeight)
{
    translate([0, 0, 0])
    roundedCube(size = [boardWidth, boardWidth, plateHeight],
                sidesOnly = true);
}
