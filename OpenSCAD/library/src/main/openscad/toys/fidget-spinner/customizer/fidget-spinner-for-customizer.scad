
// preview[view:south, tilt:top]

use <../fidget-spinner.scad>

//echo("fsfc:1 - ", cutoutName);

/* [Spinner_Parameters] */
cutoutHolderType = "Cylinder"; // [Cylinder, Knurl]
cutoutName = "Creeper";    // [Adafruit, Aqua Dude, Bat, Clover, Creeper, Fidget (Time Bandits), Heart, Pacman, OSHW, Rebel Alliance, SSI, Spur, Star, Star Trek]

fidgetSpinner(cutoutHolderType, cutoutName);