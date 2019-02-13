
use <../break-free-earrings.scad>

claspType = "pinch"; // [pinch, loop]

// this affects the roundness of the spiral
$fa = 2;

/* [Hidden] */

breakFreeEarring(claspType = claspType,
					radius = 25,
					spirals = 6,
					thickness = 2.5);
