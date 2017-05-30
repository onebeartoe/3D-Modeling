
use <../../basics/rounded-edges/rounded-cube.scad>

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

playerShotX = 62;

invaderScene(playerShotX = playerShotX);

/**
 * This module loops over rows and columns for the invaders.
 */
module invaders()
{
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
}

/**
 * This is the main method of the scipt.  Call this to generate a Space Invader
 * scene.
 */
module invaderScene(playerShotX)
{
    union()
    {
        // background layer
        roundedCube(boardSize, cornerRadius, sides=20, sidesOnly=true);

        mysteryShip();

        invaders();
        
        missiles(playerShotX);

        shields();
        
        player();
    }
}

/**
 * These are the missile shot by the 
 * @return 
 */
module missiles(playerShotX)
{
    invaderMissile1 = "../../external-resources/arcade/invaders/sideburn/invaders_v2_missle1.stl";
    invaderMissile2 = "../../external-resources/arcade/invaders/sideburn/invaders_v2_missle2.stl";
    
    playerMissile = "../../external-resources/arcade/invaders/sideburn/invaders_v2_missle3.stl";
    
    color("blue")
    translate([28, 60, 0])
    scale([0.5, 0.5, 0.5])
    import(invaderMissile1);
    
    color("purple")
    translate([100, 40, 0])
    scale([0.5, 0.5, 0.5])
    import(invaderMissile2);    
    
    color("green")
// x was 60            
    translate([playerShotX, 40, 0])
    scale([0.5, 0.5, 0.5])
    import(playerMissile);
}

/**
 * This module adds the mystery ship at the top of the screen.
 */
module mysteryShip()
{
    x = 90;
    y = boardLength - 5;
    z = 0;
    
    color("orange")
    translate([x, y, z])
    scale([0.5, 0.5, 0.5])
    import(mysteryShipStl);
}

module player()
{
    playerStl = "../../external-resources/arcade/invaders/sideburn/invaders_v2_canon.stl";
    color("green")
    translate([60, 0, 0])
    scale([0.5, 0.5, 0.5])
    import(playerStl);
}

module shields()
{
    for(c = [0:3])
    {
        columnLeftOffset = 10;
        columnSpacing = 35;
        
        x = c * columnSpacing + columnLeftOffset;
        y = boardLength * 0.15;
        
        color("brown")
        translate([x, y, 0])
        scale([0.5, 0.5, 0.5])
        import( shieldStls[0] );
    }
}