
use <../../basics/rounded-cube.scad>

alienColors = ["green", "purple", "blue"];
alienStls = ["../../external-resources/arcade/invaders/sideburn/invaders_v2_1.stl", 
			 "../../external-resources/arcade/invaders/sideburn/invaders_v2_2.stl",
			 "../../external-resources/arcade/invaders/sideburn/invaders_v2_3.stl"];

shipStl = "../../external-resources/arcade/invaders/sideburn/invaders_v2_ship.stl";
			 
boardHeight = 1;
boardLength = 130;
boardSize = [boardLength, boardLength, boardHeight];

cornerRadius = 8;

invaderColumns = 7;

union()
{
	roundedCube(boardSize, cornerRadius, sides=20, sidesOnly=true);
	
	columnSpacing = 18;
	
	for(r = [0 : 2])
	{
		color(alienColors[r])
	    for ( c = [0 : invaderColumns-1] )
	    {
	    	translate([c*columnSpacing+9, boardLength - (r*15+6), 0])
	    	scale([0.5, 0.5, 0.5])
	    	import(alienStls[r]);
	    }
    }
    
    color("orange")
    translate([40, 5, 0])
    import(shipStl);	
}
