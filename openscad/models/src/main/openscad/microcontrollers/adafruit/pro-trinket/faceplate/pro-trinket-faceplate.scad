
module proTrinketFacePlate(xLength = 23,
                            yLength = 23,
                            zLength = 3)
{
    difference()
    {
        cube(center = true,
             size = [xLength, yLength, zLength]);

        trinketCutout();
    }
}


module trinketCutout()
{
    usb_xLength = 8.2;
    usb_yLength = 3.8;

    pcb_xLength = 15.5;
    pcb_yLength = 3;     //2.6;

    zLength = 10;

    union()
    {
        yTranslate = (pcb_yLength / 2.0) + (usb_yLength / 2.0) - 0.01;
        translate([0, yTranslate, 0])
        trinketUsbCutout(xLength = usb_xLength,
                         yLength = usb_yLength,
                         zLength = zLength);

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
    cube(center = true,
         size = [xLength, yLength, zLength]);
}


module trinketUsbCutout(xLength, yLength, zLength)
{
    color("pink")
    cube(center = true,
         size = [xLength, yLength, zLength]);
}


