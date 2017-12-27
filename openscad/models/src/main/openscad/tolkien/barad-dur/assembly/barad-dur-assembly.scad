
use <../tower-segment/tower-segment.scad>

use <../../../external-resources/adafruit/uncanny-eyes/LCD_Top.scad>

module baradDurAssembly()
{
	topRadius = 30;

	towerSegment_zLength = 150;

	baradDurAssembly_top(towerSegments_zLength = towerSegment_zLength);

	// tower segment 1
//	translate([0, 0, towerSegment_zLength])
//	baradDur_towerSegment(topRadius = topRadius, zLength=towerSegment_zLength);

	// tower segment 0 - bottom most tower segment
	baradDur_towerSegment(topRadius = topRadius, zLength=towerSegment_zLength);
}

/** Support functions and modules follow. **/

module baradDurAssembly_top(towerSegments_zLength)
{
uncannyEyes_lcdTop();

	glassHolderPath = "/home/luke/Versioning/world/beto-land-world/3d-printing/adafruit/uncanny-eyes/files/LCD_Top.stl";

	xTranslate = 100;
	yTranslate = -0;
	zTranslate = towerSegments_zLength - 120;

	color("green")
	translate([xTranslate, yTranslate, zTranslate])
	rotate([90, 0, 0])
	import(glassHolderPath);
}
