
use <../../neje-laser-engraver-disk-jig.scad>

cutoutDiameter = 40; // [5:100]

zTranslate = nejeLaserEngraverDiskJig_zLength();

translate([0,0,zTranslate])
rotate([180, 0, 0])
nejeLaserEngraverDiskJig(diameter = cutoutDiameter);
