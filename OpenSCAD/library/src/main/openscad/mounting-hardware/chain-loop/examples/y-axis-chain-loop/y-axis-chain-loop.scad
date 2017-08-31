
use <../../chain-loop.scad>

color("blue")
translate([-25, 0, 0])
chainLoop(cutoutAxis = "z");

color("orange")
translate([0, 0, 0])
chainLoop(cutoutAxis = "z",
		  xLength = 20,
		  xPercentage = 0.2,
		  yPercentage = 0.41);
