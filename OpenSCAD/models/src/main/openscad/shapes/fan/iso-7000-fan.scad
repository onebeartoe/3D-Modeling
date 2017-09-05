
/**
 https://blog.adafruit.com/2017/04/21/view-all-the-iso-7000-iec-60417-graphical-symbols-for-use-on-equipment/

 https://www.iso.org/obp/ui/#iso:pub:PUB400008:en

 https://www.iso.org/obp/ui/#iso:grs:7000:0089
*/

module fan(height=1)
{
    linear_extrude(height=height)
    fan2D();
}

module fan2D()
{
    union()
    {
        fanHub();
        
        fanBlades();
    }
}

module fanBlade()
{
    difference()
    {
        fanBladePartA();

        translate([0, 4.5, 0])
        fanBladePartB();
    }
}

module fanBlades()
{
    for(i = [0 : 3])
    {
//        echo(i);
        
        rotate([0,0,i*90])
        translate([7,0,0])
        
        fanBlade();
    }
}

/**
 * This is the first part of the fan blade.  it only has circle with the main 'u' 
 * shape cut out.
 */
module fanBladePartA()
{
    difference()
    {        
        circle(r=5, $fn=30);
        
        translate([-3, -8,0])
        circle(r = 8, $fn=30);
    }    
}

/**
 * This part is the cutout for the right side round end
 */
module fanBladePartB()
{
    difference()
    {
        translate([2, -10, 0])
        square([3,5]);

        translate([3.2, -5, 0])
        circle(r=1.8, $fn=30);
    }    
}

module fanHub()
{
    difference()
    {
        circle(r=3, $fn=30);
        
        circle(r=2, $fn=30);
    }
}

module fanThumbnail()
{
    fan(height=1);
}
