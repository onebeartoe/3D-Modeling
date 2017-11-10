
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
		zTranslate = (zLength - bed_zLength) / 2.0;
		color("blue")
		translate([xTranslate, zTranslate, 0])
		cube([bed_xLength, bed_yLength, bed_zLength]);
	}
}
