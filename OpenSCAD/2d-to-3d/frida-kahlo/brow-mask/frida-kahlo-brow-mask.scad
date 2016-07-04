
use <../../../shapes/open-cylinder/open-cylinder.scad>

use <../18-frida-kahlo-book-lede.w1200.h630.scad>

mask();

module mask()
{
//	union()
	difference()
	{
		fridaKalohBrow(6);

		rotate([90,0,0])		
		translate([-56,3,-9])
		
		
//		$fn = 100;
		
		cylinder(r=2.1,
                 h=24,
                 $fn = 100);
		
//		openCylinder(height = 24,
//                    outerRadius = 2.5,
//                    innerRadius = 2);
	}
}
