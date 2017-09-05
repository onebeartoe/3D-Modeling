
use <../coins-pendants-ornaments.scad>

/* [General] */
height = 3; // [1:10]
includeGimbal = "yes"; // [yes, no]

/* [Inner Icon] */
innerIcon = "Tree"; // [Tree, Cross, Throwie, Star of David, Crescent Star, Star, Blue Moon, Clover, Heart, Horseshoe, Hourglass, OSHW, Texas, Africa, Oval, Balloon, Circle]
innerIconXyScale = 1.15; // [-1 : 0.05 : 30]
innerIconOffsetY = -13; // [-35:35]

/* [Outer Icon] */
outerIcon = "Tree"; // [Tree, Cross, Star of David, Crescent Star, Star, Blue Moon, Clover, Heart, Horseshoe, Hourglass, OSHW, Texas, Africa, Oval, Balloon, Circle]
outerIconXyScale = 0.4; // [-1 : 0.05 : 25]
outerIconCount = 8; // [1:15]

/* [Hidden] */

$fn=100;

ornament(height = height,
         includeGimbal = includeGimbal,
         innerIcon = innerIcon,
         innerIconXyScale = innerIconXyScale,
         innerIconOffsetY = innerIconOffsetY,
         outerIcon = outerIcon,
         outerIconXyScale = outerIconXyScale,
         outerIconCount = outerIconCount);
