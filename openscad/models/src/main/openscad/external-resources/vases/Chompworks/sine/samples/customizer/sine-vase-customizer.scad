
use <../../sine-vase.scad>

vaseType = "cylinder"; // [cube, cylinder, sphere]

internalCutout_bottomRadius = 43; // [30 : 1 : 45]

vaseMode_topChopOff_zOffset = 26; // [-50 : 1 : 50]

/* [Hidden] */

sineVase(internalCutout_bottomRadius = internalCutout_bottomRadius,
         vaseMode_topChopOff_zOffset = vaseMode_topChopOff_zOffset,
         vaseType = vaseType);
