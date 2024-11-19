
function neonLikeLedStrip_width() = 6;

function neonLikeLedStrip_height() = 13;

module neonLikeLedStrip(length = 10)
{
    union()
    {
        radius = neonLikeLedStrip_width() / 2.0;

        cubeX = neonLikeLedStrip_height() - radius;

        cubeY = neonLikeLedStrip_width();

        color("white")
        cube([cubeX, cubeY, length]);
    
        color("green")
        translate([cubeX, radius, 0])
        cylinder(r = radius, h= length, $fn = 70);
    }
}
