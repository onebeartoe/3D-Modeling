
spurStl = "../../../shapes/spurs/spurs-a.stl";

littleSpurCount = 10;

littleSpurScale = 0.125;

coin();

module coin()
{
    difference()
    {
        // main disk
    	cylinder (h = 2, r=55, center = true, $fn=100);
        
        // centered spur
        translate([0,0,-5])
    	scale([0.35, 0.35, 2.0])
    	import(spurStl);
        
        // outer spurs
        for ( i = [0 : littleSpurCount] )
        {
            rotate( i * 360 / (littleSpurCount+1), [0, 0, 1])
            translate([0, 43, -5])
            scale([littleSpurScale, littleSpurScale, 2.0])
            import(spurStl);
        }
    }
}   