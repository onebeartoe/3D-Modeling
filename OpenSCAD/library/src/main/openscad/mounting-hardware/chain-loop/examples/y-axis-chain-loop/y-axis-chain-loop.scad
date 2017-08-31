
use <../../chain-loop.scad>

color("orange")
translate([0, 0, 0])
chainLoop(cutoutAxis = "z",
		  yPercentage = 0.2368,
          zPercentage = 0.4319);
