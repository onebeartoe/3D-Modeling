
use <../../../laser-engraver-jig.scad>

use <../../neje-dk-8-kz-bed.scad>

module nejeLaserEngraverDiskJig(diameter = 40)
{
	bed_xLength = nejeDk8KzBed_xLength();
	bed_yLength = nejeDk8KzBed_yLength();
	bed_zLength = nejeDk8KzBed_zLength();

	xyIncrease = 3 * 2;

	xLength = nejeDk8KzBed_xLength() + xyIncrease;
	yLength = nejeDk8KzBed_yLength() + xyIncrease;
	zLength = nejeLaserEngraverDiskJig_zLength();

	difference()
	{
		nejeLaserEngraverDiskJig_block(bed_xLength, bed_yLength, bed_zLength,
						 			   xLength, yLength, zLength);

		nejeLaserEngraverDiskJig_cutout(diameter, xLength, yLength, zLength);
	}
}

/** Support functions and modules follow. **/

function nejeLaserEngraverDiskJig_zLength() = nejeDk8KzBed_zLength() * 2;

module nejeLaserEngraverDiskJig_block(bed_xLength, bed_yLength, bed_zLength,
				 					  xLength, yLength, zLength)
{
	laserEngraverJig(bed_xLength, bed_yLength, bed_zLength,
					 xLength, yLength, zLength);
}

module nejeLaserEngraverDiskJig_cutout(diameter, xLength, yLength, zLength)
{
	radius = diameter / 2.0;
	xTranslate = xLength / 2.0;
	yTranslate = yLength / 2.0;
	translate([xTranslate, yTranslate, -0.01])
	cylinder(r=radius, h=10);
}
