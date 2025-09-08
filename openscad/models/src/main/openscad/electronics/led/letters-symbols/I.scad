
module I(height = 3, showBackground = false)
{
    cube([30, 3, height], center = true);

    if(showBackground)
    {
        color("green")
        cube([30, 3, 1], center = true);
    }
}