
use <../../../laser-engraver-jig.scad>

use <../../neje-dk-8-kz-bed.scad>

module nejeLaserEngraverDiskJig()
{
	bed_xLength = nejeDk8KzBed_xLength();
	bed_yLength = nejeDk8KzBed_yLength();
	bed_zLength = nejeDk8KzBed_zLength();

	xyIncrease = 3 * 2;

	xLength = nejeDk8KzBed_xLength() + xyIncrease;
	yLength = nejeDk8KzBed_yLength() + xyIncrease;
	zLength = nejeDk8KzBed_zLength() * 2;

	difference()
	{
		nejeLaserEngraverDiskJig_block(bed_xLength, bed_yLength, bed_zLength,
						 			   xLength, yLength, zLength);

		nejeLaserEngraverDiskJig_cutout(xLength, yLength, zLength);
	}
}

/** Support functions and modules follow. **/

module nejeLaserEngraverDiskJig_block(bed_xLength, bed_yLength, bed_zLength,
				 					  xLength, yLength, zLength)
{
	laserEngraverJig(bed_xLength, bed_yLength, bed_zLength,
					 xLength, yLength, zLength);
}

module nejeLaserEngraverDiskJig_cutout(xLength, yLength, zLength)
{
	radius = 38 / 2.0;
	xTranslate = xLength / 2.0;
	yTranslate = yLength / 2.0;
	translate([xTranslate, yTranslate, -0.01])
	cylinder(r=radius, h=7);//, center=true);
}
