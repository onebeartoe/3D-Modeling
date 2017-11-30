
use <../../../basics/rounded-edges/rounded-cube/rounded-cube.scad>

use <../../../electronics/keyboards/switch-mounting-holes/keyboard-switch-mounting-holes.scad>

module keyboardSwitchMountingPlateBase(boardLengthX,
			boardLengthY,
			cornerRadius,
			panelHeight)
{
	roundedCube(cornerRadius = cornerRadius,
				sides = 20,
				sidesOnly = true,
				size = [boardLengthX, boardLengthY, panelHeight]);
}

module keyboardSwitchMountingPlate(boardLengthX,
                                    boardLengthY,
                                    buttonCount,
                                    buttonSide,
                                    cornerRadius,
                                    panelHeight)
{
	difference()
	{
		keyboardSwitchMountingPlateBase(boardLengthX,
			 boardLengthY,
			 cornerRadius,
		 	 panelHeight);

		keyboardSwitchMountingHoles(buttonCount,
			  buttonSide,
			  panelHeight);
	}
}
