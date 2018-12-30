
use <../rainmaker.scad>

/* [Shell] */

height = 380; // [140 : 380]

innerRadius = 20; // [30 : 40]

outerRadius = 24; // [34 : 46]

/* [Hidden] */

i = 3; // [1:100]

rainmaker(height = height,
          outerRadius = outerRadius,
          innerRadius = innerRadius);
