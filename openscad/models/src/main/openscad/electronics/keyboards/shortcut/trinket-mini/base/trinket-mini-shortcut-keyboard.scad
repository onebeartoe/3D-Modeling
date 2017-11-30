
use <../../../switch-mounting-holes/adafruit-1009/adafruit-1009-panel.scad>

use <../../../../../basics/rounded-edges/rounded-cube-enclosure/rounded-cube-enclosure.scad>

use <../../../../../microcontrollers/adafruit/trinket-mini/mounting-standoffs/trinket-mini-mounting-standoffs.scad>

use <../../../../../electronics/keyboards/switch-mounting-holes/keyboard-switch-mounting-holes.scad>

trinketMiniShortcutKeyboard();

module frameWithTrinketMounts(boardLengthZ, cornerRadius)
{
	union()
	{
		boardLengthX = 66;
		boardLengthY = 66;
		roundedCubeEnclosure(boardLengthX = boardLengthX,
                                    boardLengthY = boardLengthY,
                                    boardLengthZ = boardLengthZ,
                                    cornerRadius = cornerRadius,
                                    xAxisCutout_yPercentage = 0.8,
                                    xAxisCutout_zPercentage = 0.8,
                                    yAxisCutout_xPercentage = 0.85,
                                    yAxisCutout_zPercentage = 0.75);

		xTranslate = (boardLengthX + cornerRadius) * 0.6;
		yTranslate = (boardLengthY + cornerRadius) * 0.3;
		zTranslate = 2;
		color("red")
		translate([xTranslate, yTranslate, zTranslate])
		trinketMiniStandoffs();
	}
}

module trinketMiniShortcutKeyboard()
{
		boardLengthZ = 30;
		buttonSide = 12;
		cornerRadius = 3;

		difference()
		{
				frameWithTrinketMounts(boardLengthZ, cornerRadius);

        // the mounting panel cut out
        panelHeight = 2;
				xTranslate = 2;
				yTranslate = 3;
				zTranslate = (boardLengthZ + cornerRadius) - panelHeight + 0.01;
        xyScale = 1.02;
				translate([xTranslate, yTranslate, zTranslate])
		    color("orange")
		    scale([xyScale, xyScale, 1])
		    adafruit10009SwitchPanel(boardLengthX = 60,
                             		 panelHeight = panelHeight);

        // this is the cutout to create room for the switches to be installed
		 panelCutout_xLength = buttonSide + 45;
		 panelCutout_yLength = (buttonSide + 4) * 4 - 4;
		 panelCutout_zLength = 10;
		 panelCutout_xTranslate = 2;
		 panelCutout_yTranslate = 2;
		 panelCutout_zTranslate = (boardLengthZ + cornerRadius) - panelCutout_zLength;// - 1;  // the minus 1 is for the panel mount height
		 color("pink")
		 translate([panelCutout_xTranslate, panelCutout_yTranslate, panelCutout_zTranslate])
		 cube([panelCutout_xLength, panelCutout_yLength, panelCutout_zLength]);
	}
}
