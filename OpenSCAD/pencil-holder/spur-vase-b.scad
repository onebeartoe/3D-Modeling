
spurStl = "../../lamp-shade-scallops/spur/spurs-a.stl";

littleSpurCount = 6;

littleSpurScale = 0.125;

difference()
{
    // vase
    difference()
    {
        // outer vase
        translate([0,0,0])
        cylinder (h = 70, r=55, center = true, $fn=100);
        
        // remvoed inner vasecentered spur
        translate([0,0,5])
        cylinder (h = 70, r=50, center = true, $fn=100);
    }
    
    // outer spurs
    for ( i = [0 : 5] )
    {
        rotate([
                90, 
                0,
                i * 360 / 6
        ])
        // normally x,y,z - but here y moves the little spurs up and down
        translate([15, 0, 30])
        scale([littleSpurScale, littleSpurScale, 20.2])
        import(spurStl);
    }
}