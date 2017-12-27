
/**
 * this module centers the LCD_Top.stl file from Adafruit's uncanny-eyes project.
 */
module uncannyEyes_lcdTop()
{
	translate([100, -145.469, 0])
	import("LCD_Top.stl", convexity=10);
}
