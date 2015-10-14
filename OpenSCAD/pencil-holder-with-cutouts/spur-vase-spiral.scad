
use <../shapes/cup/cup.scad>;

spurStl = "../shapes/spurs/spurs-a.stl";
spurStl = "../shapes/oshw/oshw.stl";

littleSpurCount = 16;

littleSpurScale = 0.125;  // spur scale
littleSpurScale = 0.4;    // oshw scale

vaseHeight = 300;
vaseHeight = 150;

difference()
{
	cup(cupHeight=vaseHeight);


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