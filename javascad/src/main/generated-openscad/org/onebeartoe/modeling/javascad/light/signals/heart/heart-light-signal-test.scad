use <../../../../../../../../../../../openscad/models/src/main/openscad/shapes/dome/dome.scad>

use <../../../../../../../../../../../openscad/models/src/main/openscad/shapes/heart/heart.scad>

use <../../../../../../../../../../../openscad/models/src/main/openscad/shapes/open-cylinder/open-cylinder.scad>

difference(){union() {
color([1,0.6863,0.6863])translate([0,0,13.5])difference(){dome(domePercentage=50, radius=30.0);openCylinder(height=35, innerRadius=21.0, outerRadius=51.0);translate([0,0,31])cylinder(h=9, r=6, center=true);
}translate([0,0,-1])openCylinder(height=35, innerRadius=18.5, outerRadius=21.0);color([0,1,0])cylinder(h=2, r=18.6, center=true);
}
scale([1,1,2.5])translate([0,0,-0.51])heartThumbnail();}