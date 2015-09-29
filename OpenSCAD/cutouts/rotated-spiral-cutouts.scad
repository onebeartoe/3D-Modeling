
echo ("in rotated sprial coutes .scsd");

// This is a library for evenly spacted cutouts.

spurStl = "../shapes/spurs/spurs-a.stl";

littleSpurCount = 6;

littleSpurScale = 0.125;

rowSpacing = 30;

module rotatedSpiralCutout()
//module rotatedSpiralCutout(z=0)
{
	echo("z: ", z);

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
            translate([15, 15+(z*rowSpacing), 30])
            scale([littleSpurScale, littleSpurScale, 20.2])
            import(spurStl);
        }
    }
}