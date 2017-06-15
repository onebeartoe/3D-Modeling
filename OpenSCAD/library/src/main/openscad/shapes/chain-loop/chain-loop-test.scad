
use <chain-loop.scad>

color("blue")
translate([0, -45, 0])
chainLoop();

translate([0, -22, 0])
chainLoop();

color("orange")
translate([0, 0, 0])
chainLoop(yPercentage = 0.8);

color("pink")
translate([0, 25, 0])
chainLoop(xLength = 19,
          yLength = 17,
          yPercentage = 0.4,
          zLength = 15);

