
use <treasure-troll.scad>

stlPath = "C:\\home\\world\\versioning\\beto-land-world\\3d-printing\\toys\\treasure-troll\\ercin-gunduz\\troll-doll-planter-1.stl";

showOriginal  = 0;
showHeadless  = 0;
showHeadOnly  = 1;
showTwoHeaded = 0;

if(showOriginal == 1)
{
    originalTrollWithBase(stlPath);
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