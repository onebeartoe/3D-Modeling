
use <../../../../basics/rounded-edges/rounded-cube/rounded-cube.scad>
use <../../../../external-resources/the-transformers/emblems/decepticons/plbogen/decepticon_stamp.scad>

module facePlateWithIcons(boardWidth = 77,
                          leftTileIcon = "None",
                          leftTileOn = "No",
                          plateHeight = 1,
                          rightTileOn = "No",
                          rightTitleIcon = "None")
{
//    difference()
    {
//        import ("/home/roberto/Versioning/world/betoland/electronics/adafruit/trellis/Trellis_Soundboard/sfxb-top.stl");
//        import("/Users/lando/Versioning/world/betoland-world/electronics/adafruit/trellis/Trellis_Soundboard/sfxb-top.stl");

        difference()
        {
            union()
            {
                if(leftTileOn == "Yes")
                {
                    xTranslate = -boardWidth;
                    yTranslate = 0;
                    zTranslate = 0.5;
                    translate([xTranslate, yTranslate, zTranslate])
                    facePlateWithIcons_leftTile(boardWidth = boardWidth,
                                                leftTileIcon = leftTileIcon,
                                                plateHeight = plateHeight);
                }

                facePlateWithIcons_centerTile(boardWidth = boardWidth, plateHeight = plateHeight);

                if(rightTileOn == "Yes")
                {

                }
            }

            facePlateWithIcons_centerTile_cutouts_screws();
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

module facePlateWithIcons_leftTile(boardWidth, leftTileIcon, plateHeight)
{


    xyScale = 0.3;
    xTranslate = 35;
    zTranslate = plateHeight * 2;
    color("purple")
    translate([0, 0, 1])
    scale([xyScale, xyScale, 2])
    plbogen_deceopticonStamp();


    roundedCube(cubeCentered = true,
                size = [boardWidth, boardWidth, plateHeight],
                sidesOnly = true);
}
