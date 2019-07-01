
iconColor = "green"; // [pink, red, black, white, yellow, blue, green]

leftTileOn = "Yes"; // [Yes, No]

leftTileIcon = "Mario";   // [Autobot, Decepticon, Luigi, Mario, Rebel, Trooper]

rightTileOn = "Yes"; // [Yes, No]

rightTileIcon = "Luigi";   // [Autobot, Decepticon, Luigi, Mario, Rebel, Trooper]



/* [Hidden] */

use <../face-plate-with-icons.scad>

facePlateWithIcons(iconColor = iconColor,
                   leftTileIcon = leftTileIcon,
                   leftTileOn = leftTileOn,
                   rightTileIcon = rightTileIcon,
                   rightTileOn = rightTileOn);
