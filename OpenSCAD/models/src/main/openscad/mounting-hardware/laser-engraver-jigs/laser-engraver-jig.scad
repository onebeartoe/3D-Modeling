
module laserEngraverJig(bed_xLength, bed_yLength, bed_zLength,
						xLength, yLength, zLength)
{
	laserEngraverJig_base(bed_xLength, bed_yLength, bed_zLength,
						  xLength, yLength, zLength);
}

/** Support functions and modules follow. **/

module laserEngraverJig_base(bed_xLength, bed_yLength, bed_zLength,
							 xLength, yLength, zLength)
{
	difference()
	{
		// main block
		cube([xLength, yLength, zLength]);

		// bed cutout
		xTranslate = (xLength - bed_xLength) / 2.0;
		yTranslate = (yLength - bed_yLength) / 2.0;
		color("green")
		translate([xTranslate, yTranslate, -0.01])
		cube([bed_xLength, bed_yLength, bed_zLength + 0.01]);
	}
}
