
use <../../light-signal.scad>

use <../light-signal-stand.scad>

translate([0, 0, 55])
rotate([0,90,0])
lightSignal(icon1 = "bat");

lightSignalStand();
