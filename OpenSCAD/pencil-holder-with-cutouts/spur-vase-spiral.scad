
use <../shapes/cup/cup.scad>;

vaseHeight = 150;

difference()
{
	cup(cupHeight=vaseHeight);

	propossedRotatedSpiralCutout();
}

module propossedRotatedSpiralCutout(spurStl = "../shapes/oshw/oshw.stl",
									littleSpurCount = 16,
									littleSpurScale = 0.4)
{
    for ( i = [0 : littleSpurCount] )
    {	
        rotate([
                90, 
                0,
                i * 30
        ])
        // normally x,y,z - but here y moves the little spurs up and down
        translate([15, 5 * i, 30])
        scale([littleSpurScale, littleSpurScale, 20.2])
        import(spurStl);
    }
}