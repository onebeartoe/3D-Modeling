
base_xTranslate = -1;  // [-10: 0.1 :10]

base_yTranslate = -1;  // [-10: 0.1 :10]

stand_connectorBar_xLength = 8; // [-10: 0.1 :10]

stand_top_xTranslate = 9.105;  // [-10: 0.1 :10]

stand_top_yTranslate = 9.85;  // [-10: 0.1 :10]

iconType = "Mario";   // [Aqua Dude, Bass Clef, Cat, Creeper, Fan, Fish, Heart, Light Bulb, Luigi, Mario, Moon, Rebel, Spur, Sun, The Kid, Thundercat, Treble Clef, Trooper]

iconColor = "blue"; // [pink, red, black, white, yellow, blue, green]

icon_xOffset = -9;  // [-30:30]

icon_yOffset = 34;  // [-10:200]

icon_zOffset = 19;  // [-30:30]

iconXyScale = 1.0;  // [-1: 0.1 :10]

bed_cutout_zLength = 10; // [4.2 : 15]

height = 40; // [19.125 : 60]

/* [Hidden] */

use <../../half-circle-phone-stand.scad>
    
halfCirclePhoneStand(base_xTranslate = base_xTranslate,
                     base_yTranslate = base_yTranslate,
                     bed_cutout_zLength = bed_cutout_zLength,
                     height = height,
                     iconColor = iconColor,
                     icon_xOffset = icon_xOffset,
                     icon_yOffset = icon_yOffset,
                     icon_zOffset = icon_zOffset,
                     iconXyScale = iconXyScale,
                     iconType = iconType,
                     stand_connectorBar_xLength = stand_connectorBar_xLength,
                     stand_top_xTranslate = stand_top_xTranslate,
                     stand_top_yTranslate = stand_top_yTranslate);

