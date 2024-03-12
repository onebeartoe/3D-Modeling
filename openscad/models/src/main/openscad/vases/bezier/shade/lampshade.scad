
module bezierLampshade(beadRadius = 6, ringRadius = 60)
{
    $fn = 20;

    echo("bezierLapshade()");

    count = 30;

    for(s = [0 : count])
    {
        zRotate = s * (360 / count);

        rotate([0, 0, zRotate])
        translate([ringRadius,0,0])
        sphere(r=beadRadius);
    }
}
