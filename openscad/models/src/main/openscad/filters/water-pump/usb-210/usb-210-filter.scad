
use <../circle-attachement/water-pump-filter.scad>

use <filter-outline/usb-210-filter-outline.scad>


module usb210Filter()
{
	difference()
	{
		usb210Filter_shell();

		usb210Filter_filterOutlineCutout();

		usb210Filter_shell_cutouts();
	}
}

module usb210Filter_filterOutlineCutout()
{
	translate([0, 0, 5])
	usb210_filter_attachementOutline(h = 200);
}

module usb210Filter_shell()
{
	xLength = usb210Filter_shell_xLength();
	yLength = usb210Filter_shell_yLength();
	zLength = usb210Filter_shell_zLength();

	zTranslate = (zLength / 2.0) ;

	translate([0, 0, zTranslate])
	cube([xLength, yLength, zLength], center=true);
}

module usb210Filter_shell_cutouts()
{
	zTranslate = 20;

	translate([0, 0, zTranslate])
	waterPumpFilter_yCutouts(height = 25);

	translate([0, 0, zTranslate])
	waterPumpFilter_xCutouts(height = 25, length = 10);
}

function usb210Filter_shell_xLength() = 32;

function usb210Filter_shell_yLength() = 38;

function usb210Filter_shell_zLength() = 45;
