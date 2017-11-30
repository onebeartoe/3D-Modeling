
use <../../../shapes/open-cylinder/open-cylinder.scad>

use <../18-frida-kahlo-book-lede.w1200.h630.scad>

mask();

module mask()
{
//	union()
	difference()
	{
		fridaKalohBrow(6);

		rotate([90, 0, -11])		
		translate([-55,3,-9])
		
		cylinder(r=2.1,
                 h=44,
                 $fn = 100);
	}
}
