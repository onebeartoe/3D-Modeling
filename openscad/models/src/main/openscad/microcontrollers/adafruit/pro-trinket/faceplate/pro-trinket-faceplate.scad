
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
    usb_xLength = 8.2;
    usb_yLength = 3.42;

    pcb_xLength = 15.5;
    pcb_yLength = 2.6;

    zLength = 10;

    union()
    {
        translate([-4, 10.5, -0.01])
        trinketUsbCutout(xLength = usb_xLength,
                         yLength = usb_yLength,
                         zLength = zLength);


        translate([-4, 8, -0.01])
        trinketPcbCutout(xLength = pcb_xLength,
                         yLength = pcb_yLength,
                         zLength = zLength);
    }
}


module trinketPcbCutout(xLength,
                        yLength,
                        zLength)
{
    color("purple")
    cube(size = [xLength, yLength, zLength]);
}


module trinketUsbCutout(xLength, yLength, zLength)
{
    color("pink")
    cube(size = [xLength, yLength, zLength]);
}


