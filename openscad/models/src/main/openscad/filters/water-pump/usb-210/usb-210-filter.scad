
use <../circle-attachement/water-pump-filter.scad>

use <filter-outline/usb-210-filter-outline.scad>


module usb210Filter()
{
	difference()
	{
		usb210Filter_shell();

		usb210Filter_filterOutlineCutout();

		waterPumpFilter_yCutouts();
	}
}

module usb210Filter_filterOutlineCutout()
{
	usb210_filter_attachementOutline(h = 200);
}

module usb210Filter_shell()
{
	xLength = usb210Filter_shell_xLength();
	yLength = usb210Filter_shell_yLength();
	zLength = usb210Filter_shell_zLength();

	zTranslate = zLength / 2.0;

	translate([0, 0, zTranslate])
	cube([xLength, yLength, zLength], center=true);
}

function usb210Filter_shell_xLength() = 150;

function usb210Filter_shell_yLength() = 170;

function usb210Filter_shell_zLength() = 170;
