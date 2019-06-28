use <../../../../../../../../../../../../../openscad/models/src/main/openscad/shapes/dome/dome.scad>

use <../../../../../../../../../../../../../openscad/models/src/main/openscad/shapes/heart/heart.scad>

use <../../../../../../../../../../../../../openscad/models/src/main/openscad/shapes/open-cylinder/open-cylinder.scad>

difference(){union() {
color([1,0.6863,0.6863])translate([0,0,13.5])difference(){dome(domePercentage=50, radius=30.0);openCylinder(height=35, innerRadius=21.0, outerRadius=51.0);translate([0,0,31])cylinder(h=9, r=6, center=true);
}translate([0,0,-1])openCylinder(height=35, innerRadius=18.5, outerRadius=21.0);color([0,1,0])cylinder(h=2, r=18.6, center=true);
}
translate([0,8.5,-1.21])scale([0.1,0.1,2.5])heartThumbnail();translate([-4.2,10.5,-1.21])scale([0.1,0.1,2.5])heartThumbnail();translate([4.2,10.5,-1.21])scale([0.1,0.1,2.5])heartThumbnail();translate([8.7,9.5,-1.21])scale([0.1,0.1,2.5])heartThumbnail();translate([-8.7,9.5,-1.21])scale([0.1,0.1,2.5])heartThumbnail();translate([-11.7,6,-1.21])scale([0.1,0.1,2.5])heartThumbnail();translate([11.7,6,-1.21])scale([0.1,0.1,2.5])heartThumbnail();translate([12,1,-1.21])scale([0.1,0.1,2.5])heartThumbnail();translate([-12,1,-1.21])scale([0.1,0.1,2.5])heartThumbnail();translate([-9,-3,-1.21])scale([0.1,0.1,2.5])heartThumbnail();translate([9,-3,-1.21])scale([0.1,0.1,2.5])heartThumbnail();translate([5,-7,-1.21])scale([0.1,0.1,2.5])heartThumbnail();translate([-5,-7,-1.21])scale([0.1,0.1,2.5])heartThumbnail();translate([0,-11,-1.21])scale([0.1,0.1,2.5])heartThumbnail();}