
use <../../../basics/rounded-edges/rounded-cube/rounded-cube.scad>

use <keyboard-switch-mounting-holes.scad>

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

		keyboardSwitchMountingHoles(buttonCount,
			  buttonSide,
			  panelHeight);
	}
}
