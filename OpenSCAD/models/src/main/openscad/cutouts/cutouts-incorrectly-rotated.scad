
spurStl = "../shapes/spurs/spurs-a.stl";

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
        translate([0,0,-5])
        cylinder (h = 70, r=50, center = true, $fn=100);
    }
    
    // removed spurs after this
    
    // bottom spur
    translate([0,0,-5])
	scale([0.35, 0.35, 12.0])
	import(spurStl);

    
    // outer spurs
    for ( i = [0 : littleSpurCount] )
    {
        rotate(
            [
                i * 360 / (littleSpurCount+1),
                90,
                0
            ]
        )
        scale([littleSpurScale, littleSpurScale, 20.0])
        import(spurStl)
        sphere(300)
        ;
    }   
}