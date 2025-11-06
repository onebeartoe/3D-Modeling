
use <../heat-sink.scad>

difference()
{
    heatSink();

    cutoutSize = 95;
    translate([0, -cutoutSize / 2.0, -0.01])
    cube(size = [cutoutSize, cutoutSize,85]);
}
