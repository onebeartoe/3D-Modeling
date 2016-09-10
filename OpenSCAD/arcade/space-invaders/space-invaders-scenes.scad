
use <../../basics/rounded-cube.scad>

alienColors = ["green", "purple", "blue"];
alienStls = ["../../external-resources/arcade/invaders/sideburn/invaders_v2_1.stl", 
			 "../../external-resources/arcade/invaders/sideburn/invaders_v2_2.stl",
			 "../../external-resources/arcade/invaders/sideburn/invaders_v2_3.stl"];

mysteryShipStl = "../../external-resources/arcade/invaders/sideburn/invaders_v2_ship.stl";

shieldStls = ["../../external-resources/arcade/invaders/sideburn/invaders_v2_sheild4.stl"];

boardHeight = 1;
boardLength = 130;
boardSize = [boardLength, boardLength, boardHeight];

cornerRadius = 8;

invaderColumns = 7;

union()
{
    // background layer
    roundedCube(boardSize, cornerRadius, sides=20, sidesOnly=true);

    // mystery ship at the top of the screen
    color("orange")
    translate([60, boardLength -5, 0])
    scale([0.5, 0.5, 0.5])
    import(mysteryShipStl);

    // loops for the invaders
    columnSpacing = 18;
    columnLeftOffset = 9;
    for(r = [0 : 2])
    {
        color(alienColors[r])
        for ( c = [0 : invaderColumns-1] )
        {
            x = c * columnSpacing + columnLeftOffset;
            translate([x, boardLength - (r*15+24), 0])
            scale([0.5, 0.5, 0.5])
            import(alienStls[r]);
        }
    }
    
    for(c = [0:3])
    {
        columnLeftOffset = 20;
        columnSpacing = 30;
        x = c * columnSpacing + columnLeftOffset;
        y = boardLength * 0.15;
        color("green")
        translate([x, y, 0])
        scale([0.5, 0.5, 0.5])
        import( shieldStls[0] );
    }
}
