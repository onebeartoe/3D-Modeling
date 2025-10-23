
module proTrinketFacePlate(xLength = 23,
                            yLength = 23,
                            zLength = 3)
{
//    difference()
    {
        cube(center = true,
             size = [xLength, yLength, zLength]);

        trinketCutout();
    }
}


module trinketCutout()
{
    zLength = 10;

    union()
    {
        trinketUsbCutout(zLength = zLength);

        trinketPcbCutout(zLength = zLength);
    }
}


module trinketPcbCutout(zLength)
{
    color("purple")
    translate([-4, 8, 26.9])
    cube(size = [15.5, 2.6, zLength]);
}


module trinketUsbCutout(zLength)
{
    color("pink")
    // color("purple")
    translate([-4, 10.5, 30.4])
    cube(size = [8.2, 3.42, zLength]);
}


