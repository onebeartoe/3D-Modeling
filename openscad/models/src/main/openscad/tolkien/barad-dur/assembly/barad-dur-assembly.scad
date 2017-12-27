
use <../tower-segment/tower-segment.scad>

module baradDurAssembly()
{
	towerSegment_zLength = 20;

	baradDurAssembly_top(towerSegment_zLength);

	// tower segment 1
	translate([0, 0, towerSegment_zLength])
	baradDur_towerSegment(zLength=towerSegment_zLength);

	// tower segment 0 - bottom most tower segment
	baradDur_towerSegment(zLength=towerSegment_zLength);
}

module baradDurAssembly_top(towerSegment_zLength)
{
	glassHolderPath = "/home/luke/Versioning/world/beto-land-world/3d-printing/adafruit/uncanny-eyes/files/LCD_Top.stl";

	xTranslate = -100;
	yTranslate = -100;
	zTranslate = towerSegment_zLength - 100;

	translate(xTranslate, yTranslate, zTranslate)
	rotate([90, 0, 0])
	import(glassHolderPath);
}
