
use <../treasure-troll.scad>

// This next commented STL slowed OpenSCAD too much.  So the Blender decimate too was used to reduce the number of faces.
//stlPath = "C:\\home\\world\\versioning\\beto-land-world\\3d-printing\\toys\\treasure-troll\\ercin-gunduz\\troll-doll-planter-1.stl";
stlPath = "C:\\home\\world\\versioning\\beto-land-world\\3d-printing\\toys\\treasure-troll\\ercin-gunduz\\treasure-troll-stl-to-openscad-via-blender-and-back-to-stl-2.stl";

showOriginal  = 0;
showHeadless  = 0;
showHeadOnly  = 1;
showTwoHeaded = 1;

if(showOriginal == 1)
{
    originalTroll(stlPath);
}

if(showHeadless == 1)
{
    headlessTroll(stlPath);
}

if(showHeadOnly == 1)
{
    trollHead(stlPath);
}

if(showTwoHeaded == 1)
{
    twoHeadedTroll(stlPath);
}
