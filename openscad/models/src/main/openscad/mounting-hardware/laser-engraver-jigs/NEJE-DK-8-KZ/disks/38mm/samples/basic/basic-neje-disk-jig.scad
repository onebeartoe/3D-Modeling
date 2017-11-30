
use <../../neje-laser-engraver-disk-jig.scad>

zTranslate = nejeLaserEngraverDiskJig_zLength();

translate([0,0,zTranslate])
rotate([180, 0, 0])
nejeLaserEngraverDiskJig();
