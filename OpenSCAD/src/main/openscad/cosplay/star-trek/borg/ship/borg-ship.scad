
/**
 * the box for the Borg costume is 18" cubed.
 * 
 * 1 inch is 25.4mm
 */
sideLength = 25.4 * 18;

sheetWidth = 203.2;
sheetHeight = 271.4;

borgShip();

module borgShip()
{
	union()
	{
		cube([sideLength, sideLength, sideLength]);
		
		pokePanel();
		
		diegoPanel1();
		
		soundPanel();
		
		diegoPanel2();
	}	
}

module diegoPanel1()
{
	// bottom right
	color("red")
	translate([sideLength-sheetHeight, 0, sideLength])
	rotate(a=[90, 90, 0])
	sheet();
	
	// bottom left
	color("red")
	rotate(a=[90, 0, 0])
	sheet();
	
	// bottom right
	color("red")
	translate([sideLength-sheetHeight, 0, sheetWidth])
	rotate(a=[90, 90, 0])
	sheet();
}

module diegoPanel2()
{
	translateY = sideLength+2;
	
	// top left
	color("orange")
	translate([sideLength-sheetHeight, translateY, sideLength])
	rotate(a=[90, 90, 0])
	sheet();
	
	// bottom left
	color("orange")
	translate([sideLength-sheetHeight, translateY, sheetWidth])
	rotate(a=[90, 90, 0])
	sheet();
	
	// bottom right
	color("orange")
	translate([0, translateY, 0])
	rotate(a=[90, 0, 0])
	sheet();
}

module pokePanel()
{
	pokeTranslate = [0,90,0]; 
	
	// top left
	color("blue")
	translate([sideLength, 0, sideLength])
	rotate(a=pokeTranslate)
	sheet();
	
	// top right
	color("blue")
	translate([sideLength, sideLength-sheetHeight, sideLength])
	rotate(a=pokeTranslate)
	sheet();
	
	// bottom left
	color("blue")
	translate([sideLength, 0, sheetWidth])
	rotate(a=pokeTranslate)//[0,90,0])
	sheet();

	// bottom right
	color("blue")
	translate([sideLength, sideLength-sheetHeight, sheetWidth])
	rotate(a=pokeTranslate)
	sheet();	
}

/**
 * printable area on letter sized paper (according to http://support-sg.canon-asia.com/contents/SG/EN/8200392300.html#2)
 * 
 * 203.2 x 271.4 mm
 */
module sheet()
{
	cube([sheetWidth, sheetHeight, 2]);
}

/**
 * This panel holds the LS31FL3137 (is this right???) for sound reactive charlie plexing an 
 * LED matrix.
 */
module soundPanel()
{
	horizRotate = [0,-90,0];
	
	verticalRotate = [-90, 180, 90];
	
	// top left
	color("green")
	translate([-30,sideLength-sheetHeight,sideLength-sheetWidth])
	rotate(a=horizRotate)
	sheet();

	// top right
	color("green")
	translate([0, sheetWidth, sideLength-sheetHeight])
	rotate(a=verticalRotate)
	sheet();
	
	// top right
	color("green")
	translate([0, sideLength, 0])
	rotate(a=verticalRotate)
	sheet();
	
	// bottom right
	color("green")
	translate([-30,0,0])
	rotate(a=horizRotate)
	sheet();
}
