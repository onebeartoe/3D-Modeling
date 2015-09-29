
spurStl = "../../lamp-shade-scallops/spur/spurs-a.stl";
spurStl = "oshw.stl";

littleSpurCount = 6;

littleSpurScale = 0.125;  // spur scale
littleSpurScale = 0.4;    // oshw scale

vaseHeight = 300;
vaseHeight = 30;

difference()
{
    // vase
    difference()
    {
        // outer vase
        translate([0,0,0])
        cylinder (h = vaseHeight, r=55, $fn=100);
        
        // remvoed inner vasecentered spur
        translate([0,0,5])
        cylinder (h = vaseHeight, r=50, $fn=100);
    }
    
    y = 30;
    
    // outer spurs
    for ( i = [0 : littleSpurCount] )
    {
        rotate([
                90, 
                0,
                i * 30
//                i * 360 / 6
        ])
        // normally x,y,z - but here y moves the little spurs up and down
        translate([15, 5 * i, 30])
        scale([littleSpurScale, littleSpurScale, 20.2])
        import(spurStl);
        
//        y = y + 10;
    }
}