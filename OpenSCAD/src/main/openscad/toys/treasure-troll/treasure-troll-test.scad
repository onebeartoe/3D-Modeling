
use <treasure-troll.scad>

stlPath = "C:\\home\\world\\versioning\\beto-land-world\\3d-printing\\toys\\treasure-troll\\ercin-gunduz\\troll-doll-planter-1.stl";

//originalTrollWithBase(stlPath);

//headlessTroll(stlPath);

intersectionDifference = true;
//intersectionDifference = false;

trollHead(stlPath, intersectionDifference);