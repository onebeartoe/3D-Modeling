use <../../../../../../../../../openscad/models/src/main/openscad/shapes/heart/heart.scad>

color([1,0.6863,0.6863])difference(){cylinder(h=1, r=20, center=true);
scale([1,1,1.02])translate([0,0,-0.5])heartThumbnail();}