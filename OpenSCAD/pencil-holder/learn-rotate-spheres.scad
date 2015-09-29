for ( i = [0 : 5] )
{
    rotate( i * 360 / 6, [0, 0, 1])
    translate([0, 10, 0])
    sphere(r = 1);
}