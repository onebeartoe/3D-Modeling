
module I(height = 3, showBackground = false)
{
    cube([3, 30, height], center = true);

    if(showBackground)
    {
        color("green")
        cube([3, 30, 1], center = true);
    }
}
