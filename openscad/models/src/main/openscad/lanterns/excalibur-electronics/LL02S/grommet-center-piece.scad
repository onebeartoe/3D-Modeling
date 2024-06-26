
module grommetCenterPiece(diameter)
{
    difference()
    {
        $fn = 80;
                
        union()
        {
            overlap = 1; 
            radius = diameter / 2.0;
            bottomRadius = radius + overlap;
            wallWidth = 1.2; // for 0.4mm nozzles    
            cylinder(r=bottomRadius, h=wallWidth);  // this is the lip that extends past the grommet center cutout

            pipeRadius = radius - 0.8;
            pipeHeight = 3.2; // move just past the bottom cutout pipe
            cylinder(r=pipeRadius, h=pipeHeight); // pipe that extend into the cutout
        }

        pcbWidth = 9;
        pcbClearance = 0.6;
        pcbCutoutY = pcbWidth + pcbClearance;
        pcbCutoutZ = 15;
        cube(size=[3.6, pcbCutoutY, pcbCutoutZ], center=true);

        coilCutoutHeight = 1.2;
        coilCutoutRadius = diameter / 2.0;
        color("blue")
        translate([0, 0, -3.6])
        rotate([0, 90, 0])
        cylinder(r=coilCutoutRadius, h=coilCutoutHeight, center=true);
    }
}
