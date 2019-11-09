
use <../../sine-vase.scad>

vaseType = "cylinder"; // [cube, cylinder, sphere]

internalCutout_bottomRadius = 43; // [30 : 1 : 45]

/* [Hidden] */

sineVase(internalCutout_bottomRadius = internalCutout_bottomRadius,
         vaseType = vaseType);
