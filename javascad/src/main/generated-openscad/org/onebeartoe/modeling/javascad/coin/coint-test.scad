use <../../../../../../../../../openscad/models/src/main/openscad/shapes/heart/heart.scad>

difference(){cylinder(h=1, r=20, center=true);
scale([1,1,1.02])translate([0,0,-0.5])heartThumbnail();}