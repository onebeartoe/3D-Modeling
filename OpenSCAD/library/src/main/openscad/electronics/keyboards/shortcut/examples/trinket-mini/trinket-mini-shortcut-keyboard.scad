
use <../../../../../basics/rounded-edges/rounded-cube-enclosure/rounded-cube-enclosure.scad>

use <../../../../../microcontrollers/adafruit/trinket-mini/mounting-standoffs/trinket-mini-mounting-standoffs.scad>

trinketMiniShortcutKeyboard();

module frameWithTrinketMounts()
{
	union()
	{
		boardLengthX = 60;
		boardLengthY = 60;
		cornerRadius = 3;
		roundedCubeEnclosure(boardLengthX = boardLengthX,
							boardLengthY = boardLengthY,
							boardLengthZ = 30,
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
	frameWithTrinketMounts();


}
