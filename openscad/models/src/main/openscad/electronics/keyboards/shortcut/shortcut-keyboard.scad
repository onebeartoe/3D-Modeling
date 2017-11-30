
use <../../../basics/rounded-edges/rounded-cube-enclosure/rounded-cube-enclosure.scad>

module cutouts()
{
	echo("farto");
}

module enclosureWitoutCutouts(boardLengthX,
					 		boardLengthY,
					 		boardLengthZ,
							cornerRadius,
							xAxisCutout_yPercentage,
							xAxisCutout_zPercentage,
							yAxisCutout_xPercentage,
							yAxisCutout_zPercentage);
{
	roundedCubeEnclosure(boardLengthX = boardLengthX,
	                    boardLengthY = boardLengthY,
	                    boardLengthZ = boardLengthZ,
	                    cornerRadius = cornerRadius,
	                    xAxisCutout_yPercentage = xAxisCutout_yPercentage,
	                    xAxisCutout_zPercentage = xAxisCutout_zPercentage,
	                    yAxisCutout_xPercentage = yAxisCutout_xPercentage,
	                    yAxisCutout_zPercentage = yAxisCutout_zPercentage);
}

module shortcutKeyboard(boardLengthX,
					 		boardLengthY,
					 		boardLengthZ,
							cornerRadius,
							xAxisCutout_yPercentage,
							xAxisCutout_zPercentage,
							yAxisCutout_xPercentage,
							yAxisCutout_zPercentage)
{
	difference()
	{
		enclosureWitoutCutouts(boardLengthX = boardLengthX,
		                    boardLengthY = boardLengthY,
		                    boardLengthZ = boardLengthZ,
		                    cornerRadius = cornerRadius,
		                    xAxisCutout_yPercentage = xAxisCutout_yPercentage,
		                    xAxisCutout_zPercentage = xAxisCutout_zPercentage,
		                    yAxisCutout_xPercentage = yAxisCutout_xPercentage,
		                    yAxisCutout_zPercentage = yAxisCutout_zPercentage);

		cutouts();
	};
}
