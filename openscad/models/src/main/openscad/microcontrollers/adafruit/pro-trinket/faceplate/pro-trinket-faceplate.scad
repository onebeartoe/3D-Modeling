
module proTrinketFacePlate(xLength = 22,
                            yLength = 22,
                            zLength = 2)
{
    difference()
    {        
        // faceplate
        minkowski()
        {
            minkowskiRadius = 1;
            cube(center = true,
                 size = [xLength-minkowskiRadius, yLength-minkowskiRadius, zLength]);

            cylinder(r=1,
                     h=zLength,
                     $fn=20);
        }      

        usb_xLength = 9.0;
        usb_yLength = 3.8;

        pcb_xLength = 17.5;
        pcb_yLength = 3;

        cutoutTranslate_y = -1 * 
                            (usb_yLength / 2.0 + pcb_yLength / 2.0) / 2.0;

        translate([0, cutoutTranslate_y, 0])
        trinketCutout(usb_xLength = usb_xLength,
                        usb_yLength = usb_yLength,
                        pcb_xLength = pcb_xLength,
                        pcb_yLength = pcb_yLength);
    }
}


module trinketCutout(usb_xLength,
                     usb_yLength,
                     pcb_xLength,
                     pcb_yLength)
{
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
