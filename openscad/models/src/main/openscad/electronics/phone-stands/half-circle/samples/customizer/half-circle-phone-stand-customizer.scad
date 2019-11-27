
iconType = "Mario";   // [Aqua Dude, Bass Clef, Cat, Creeper, Fan, Heart, Light Bulb, Luigi, Mario, Moon, Rebel, Spur, Sun, Thundercat, Treble Clef, Trooper]

iconColor = "blue"; // [pink, red, black, white, yellow, blue, green]

icon_xOffset = -9;  // [-30:30]

icon_yOffset = 34;  // [-10:200]

icon_zOffset = 19;  // [-30:30]

bed_cutout_zLength = 10; // [4.2 : 15]

height = 40; // [19.125 : 60]

/* [Hidden] */

use <../../half-circle-phone-stand.scad>
    
halfCirclePhoneStand(bed_cutout_zLength = bed_cutout_zLength,
                     height = height,
                     iconColor = iconColor,
                     icon_xOffset = icon_xOffset,
                     icon_yOffset = icon_yOffset,
                     icon_zOffset = icon_zOffset,
                     iconType = iconType);

