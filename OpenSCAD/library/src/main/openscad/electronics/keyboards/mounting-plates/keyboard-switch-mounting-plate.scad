
use <../../../basics/rounded-edges/rounded-cube/rounded-cube.scad>

use <../../../electronics/keyboards/switch-mounting-holes/keyboard-switch-mounting-holes.scad>

module keyboardSwitchMountingPlateBase(boardLength,
			boardWidth,
			cornerRadius,
			panelHeight)
{
	roundedCube(cornerRadius = cornerRadius,
				sides = 20,
				sidesOnly = true,
				size = [boardLength, boardWidth, panelHeight]);
}

module keyboardSwitchMountingPlate(boardLength,
                                    boardWidth,
                                    buttonCount,
                                    buttonSide,
                                    cornerRadius,
                                    panelHeight)
{
	difference()
	{
		keyboardSwitchMountingPlateBase(boardLength,
			 boardWidth,
			 cornerRadius,
		 	 panelHeight);

		keyboardSwitchMountingHoles(buttonCount,
			  buttonSide,
			  panelHeight);
	}
}
