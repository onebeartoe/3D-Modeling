
use <../../light-signal.scad>

use <../light-signal-stand.scad>

translate([0, 0, 30])
//rotate([0,90,0])
rotate([0,0,90])
lightSignal(icon1 = "bat",
			mountingPosts = "Yes");

lightSignalStand();
