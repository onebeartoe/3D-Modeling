
use <../../../../basics/rounded-edges/rounded-cube/rounded-cube.scad>
use <../../../../external-resources/plumber-brother/l/luigi-outline.scad>
use <../../../../external-resources/plumber-brother/m/mario.scad>
use <../../../../external-resources/rebel-alliance/rebel-alliance.scad>
use <../../../../external-resources/the-transformers/emblems/decepticons/plbogen/decepticon_stamp.scad>
use <../../../../name-tags/nametags.scad>

module facePlateWithIcons(boardWidth = 77,
                          leftTileIcon = "None",
                          leftTileOn = "No",
                          plateHeight = 1,
                          rightTileOn = "No",
                          rightTileIcon = "None")
{
//    difference()
    {
//        import ("/home/roberto/Versioning/world/betoland/electronics/adafruit/trellis/Trellis_Soundboard/sfxb-top.stl");
//        import("/Users/lando/Versioning/world/betoland-world/electronics/adafruit/trellis/Trellis_Soundboard/sfxb-top.stl");

        difference()
        {
            union()
            {
                xTranslate = -boardWidth;
                zTranslate = 0.5;

                if(leftTileOn == "Yes")
                {
                    translate([xTranslate, 0, zTranslate])
                    facePlateWithIcons_sideTile(boardWidth = boardWidth,
                                                tileIcon = leftTileIcon,
                                                plateHeight = plateHeight);
                }

                facePlateWithIcons_centerTile(boardWidth = boardWidth, plateHeight = plateHeight);

                if(rightTileOn == "Yes")
                {
                    translate([-xTranslate, 0, zTranslate])
                    facePlateWithIcons_sideTile(boardWidth = boardWidth,
                                                tileIcon = rightTileIcon,
                                                plateHeight = plateHeight);
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

module facePlateWithIcons_sideTile(boardWidth, tileIcon, plateHeight)
{
    // icon
    xTranslate = 35;
    zTranslate = plateHeight * 2;

    translate([0, 0, 1])
    if(tileIcon == "Decepticon")
    {
        xyScale = 0.3;
        color("purple")

        scale([xyScale, xyScale, 2])
        plbogen_deceopticonStamp();
    }
    else if(tileIcon == "Luigi")
    {
        xyScale = 2.3;
        scale([xyScale, xyScale, 1])
        luigiThumbnail();
    }
    else if(tileIcon == "Mario")
    {
        xyScale = 2.3;
        scale([xyScale, xyScale, 1])
        marioThumbnail();
    }
    else if(tileIcon == "Trooper")
    {
        scrumtrooper(2);
    }
    else
    {
        echo("drawing no icon");
        cube([1,1,1]);
    }



    // tile
    roundedCube(cubeCentered = true,
                size = [boardWidth, boardWidth, plateHeight],
                sidesOnly = true);
}
