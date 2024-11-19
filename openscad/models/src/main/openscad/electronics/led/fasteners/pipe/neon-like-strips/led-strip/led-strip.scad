
function neonLikeLedStrip_width() = 6;

function neonLikeLedStrip_height() = 13;

module neonLikeLedStrip(length = 10)
{
    union()
    {
        color("white")
        cube([10,5,length]);
    
        color("green")
        cylinder(r = 4, h= length, $fn = 70);
    }
}
