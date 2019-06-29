
leftTileOn = "Yes"; // [Yes, No]

leftTileIcon = "Mario";   // [Autobot, Decepticon, Luigi, Mario, Rebel, Trooper]

rightTileOn = "Yes"; // [Yes, No]

rightTileIcon = "Luigi";   // [Autobot, Decepticon, Luigi, Mario, Rebel, Trooper]

/* [Hidden] */

use <../face-plate-with-icons.scad>

facePlateWithIcons(leftTileIcon = leftTileIcon,
                   leftTileOn = leftTileOn,
                   rightTileIcon = rightTileIcon,
                   rightTileOn = rightTileOn);
