
use <../../trinket-mini-mounting-standoffs.scad>

xLength = 30;
yLength = 40;
zLength = 1;

union()
{
    cube([xLength, yLength, zLength]);

    
    xTranslate = xLength / 2.0 - xHoleDeltaBottomRight() / 2.0;
    yTranslate = yLength / 2.0 - yHoleDelta() / 2.0;
    
    translate([xTranslate, yTranslate, zLength])
    trinketMiniStandoffs();
}