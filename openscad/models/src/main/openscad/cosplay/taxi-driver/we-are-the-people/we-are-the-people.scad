
module weAreThePeople(sidesOnly = false,
                      cornerRadius=5,
                      height = 1)
{
    difference()
    {
        fullDisk(sidesOnly, cornerRadius, height);

        bottomCutoff(height = 50);
    };
}

module bottomCutoff(height)
{
    color("green")
    translate([0,0, height / -2])
    cube(size=[150, 150, height], center=true);
}

module fullDisk(sidesOnly,
                cornerRadius,
                height)
{
    minkowski()
    {
        cylinder(r = 45, h = height, $fn = 90);

        if(sidesOnly)
        {
            cylinder(r=cornerRadius);
        }
        else
        {
            sphere(r=cornerRadius);
        }
    };
}