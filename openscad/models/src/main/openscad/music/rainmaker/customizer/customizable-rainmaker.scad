
use <../rainmaker.scad>

/* [Shell] */

height = 200; // [140 : 380]

innerRadius = 30; // [30 : 40]

outerRadius = 34; // [34 : 46]

/* [Hidden] */

i = 3; // [1:100]

rainmaker(height = height,
          outerRadius = outerRadius,
          innerRadius = innerRadius);
