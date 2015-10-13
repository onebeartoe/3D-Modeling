
vaseHeight = 140;

spurStl = "../shapes/spurs/spurs-a.stl";

littleSpurCount = 10;

littleSpurScale = 0.125;

rowSpacing = 30;

difference()
{
    // vase
    difference()
    {
        // outer vase
        translate([0,0,0])
        cylinder (h = vaseHeight, r=55, $fn=100);
        
        // remvoed inner vase centered spur
        translate([0,0,5])
        cylinder (h = vaseHeight, r=50, $fn=100);
    }
    
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