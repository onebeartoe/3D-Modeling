
use <croc-led-jiblet.scad>

difference()
{
    union()
    {
        blank();

        connector();
    }

    cutout_clip();
}
