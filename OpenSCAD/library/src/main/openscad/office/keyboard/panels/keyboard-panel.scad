
use <../../../basics/rounded-edges/rounded-cube/rounded-cube.scad>

module base(boardLength,
			boardWidth,
			cornerRadius,
			panelHeight)
{
	roundedCube(cornerRadius = cornerRadius,
				sides = 20,
				sidesOnly = true,
				size = [boardLength, boardWidth, panelHeight]);
}

/**
 * buttonSide - the length of the side of the rectangular cutout for the button/key
 */
module keyboardHoles(buttonCount = 4,
			 buttonSide = 5,
		 	 panelHeight = 1)
{
	x = 16;
	startY = 0;

	ySpacing = 3;
	yIncrement = buttonSide + ySpacing;

	for(i = [0 : buttonCount-1])
	{
		y = startY + (i * yIncrement);

		zLength = 2 * panelHeight + 0.2;

		color("green")
		translate([x, y, -0.1])
		cube([buttonSide, buttonSide, zLength]);
	}
}

module keyboardPanel(boardLength,
					 boardWidth,
					 buttonCount,
 					 buttonSide,
					 cornerRadius,
				 	 panelHeight)
{
	difference()
	{
		base(boardLength,
			 boardWidth,
			 cornerRadius,
		 	 panelHeight);

		keyboardHoles(buttonCount,
			  buttonSide,
			  panelHeight);
	}
}
