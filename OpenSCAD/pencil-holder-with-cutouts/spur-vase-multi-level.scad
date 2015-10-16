
use <../shapes/cup/cup.scad>;

spurStl = "../shapes/spurs/spurs-a.stl";

littleSpurCount = 10;

littleSpurScale = 0.125;

rowSpacing = 30;

difference()
{
    cup(cupHeight=140, innerRadius=50);
    
    // removed outer spurs
    for ( i = [0 : littleSpurCount],
          z = [1 : 3])
    {
        rotate([
                90, 
                0,
                i * 360 / littleSpurCount+1
        ])
        // normally x,y,z - but here y moves the little spurs up and down
        translate([15, 15+(z*rowSpacing), 30])
        scale([littleSpurScale, littleSpurScale, 20.2])
        import(spurStl);
    }
}