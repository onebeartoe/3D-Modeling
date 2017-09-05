
// preview[view:south, tilt:top]

use <../fidget-spinner.scad>

//echo("fsfc:1 - ", cutoutName);

/* [Spinner_Parameters] */

cutoutHolderType = "Cylinder"; // [Cylinder, Knurl]

cutoutName = "Clover";    // [Adafruit, Aqua Dude, Bat, Clover, Fidget (Time Bandits), Heart, Pacman, OSHW, Rebel Alliance, SSI, Spur, Star, Star Trek]

//How many spokes should the spinner have?
spokeNumber = 3; //[2,3,4,5,6,7]

// this variable determines the distance from the hub to the cut out shape.
spoke_y = 4; //[1,2,3,4,5,6,7,8]

fidgetSpinner(cutoutHolderType, cutoutName, spokeNumber, spoke_y);
