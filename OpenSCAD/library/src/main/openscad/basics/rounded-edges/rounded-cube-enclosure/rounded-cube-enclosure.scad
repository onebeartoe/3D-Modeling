

use <../rounded-cube/rounded-cube.scad>

module roundedCubeEnclosure(boardLengthX,
					 		boardLengthY,
					 		boardLengthZ,
							cornerRadius,
							xAxisCutout_yPercentage,
							xAxisCutout_zPercentage,
							yAxisCutout_xPercentage,
							yAxisCutout_zPercentage)
{
	size = [boardLengthX, boardLengthY, boardLengthZ];

	difference()
	{
		roundedCube(cornerRadius = cornerRadius,
					size=size,
		            sides=5,
		            sides=20);

		// x axis cutout
		xAxisCutout_xLength = boardLengthX * 1.1;
		xAxisCutout_yLength = boardLengthY * xAxisCutout_yPercentage;
		xAxisCutout_zLength = boardLengthZ * xAxisCutout_zPercentage;
		xAxisCutout_xTranslate = -0.05 * boardLengthX;
		xAxisCutout_yTranslate = boardLengthY / 2.0 - xAxisCutout_yLength / 2.0;
		xAxisCutout_zTranslate = boardLengthZ / 2.0 - xAxisCutout_zLength / 2.0;
		color("blue")
		translate([xAxisCutout_xTranslate,
				   xAxisCutout_yTranslate,
				   xAxisCutout_zTranslate])
		cube([xAxisCutout_xLength,
			  xAxisCutout_yLength,
			  xAxisCutout_zLength]);

	  	// y axis cutout
		yAxisCutout_xLength = boardLengthX * yAxisCutout_xPercentage;
		yAxisCutout_yLength = boardLengthY * 1.1;
		yAxisCutout_zLength = boardLengthZ * yAxisCutout_zPercentage;
		yAxisCutout_xTranslate = boardLengthX / 2.0 - yAxisCutout_xLength / 2.0;
		yAxisCutout_yTranslate = boardLengthY / 2.0 - yAxisCutout_yLength / 2.0;
		yAxisCutout_zTranslate = boardLengthZ / 2.0 - yAxisCutout_zLength / 2.0;
		color("green")
		translate([yAxisCutout_xTranslate,
				   yAxisCutout_yTranslate,
				   yAxisCutout_zTranslate])
		cube([yAxisCutout_xLength,
			  yAxisCutout_yLength,
			  yAxisCutout_zLength]);
	}
}
