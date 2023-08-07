
module grommetCenterPiece(diameter)
{

    $fn = 80;
            
    union()
    {
        overlap = 1; // this is the lip that extends past the grommet center cutout

        radius = diameter / 2.0;

        bottomRadius = radius + overlap;

        wallWidth = 1.2; // for 0.4mm nozzles    

        cylinder(r=bottomRadius, h=wallWidth);  // the bottom

        pipeRadius = radius - 0.8;

        pipeHeight = 3.2; // move just past the bottom cutout pipe

        cylinder(r=pipeRadius, h=pipeHeight);
    }
}

module bottom(radius)
{

}
