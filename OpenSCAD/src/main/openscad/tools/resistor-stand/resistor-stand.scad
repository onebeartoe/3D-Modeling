
RESISTOR_LEAD_LENGTH = 30;

resisitorStand();

module resisitorStand()
{
    resistorHolder();
}

module resistorHolder(baseLengthX = 24,
                      baseLengthY = 15,
                      baseLengthZ = 5,
                      
                      towerLengthX = 6,
                      towerLengthY = 10,
                      towerLengthZ = 18)
{
    difference()
    {
        resistorHolderUnion(baseLengthX,
                      baseLengthY ,
                      baseLengthZ ,
                      
                      towerLengthX,
                      towerLengthY,
                      towerLengthZ);

        shafts(xLength = towerLengthX);
    }

}

module resistorHolderUnion(baseLengthX,
                      baseLengthY ,
                      baseLengthZ ,
                      
                      towerLengthX,
                      towerLengthY,
                      towerLengthZ)
{
    union()
    {
        base(xLength=baseLengthX,
             yLength=baseLengthY,
             zLength=baseLengthZ);
    
        for ( i = [0 : 1] )
        {
            xIncrement = (towerLengthX/4.0) + 10;
            xTranslate = i * xIncrement;
            translate([xTranslate, 0, 0])
            tower(xLength=towerLengthX,
                  yLength=towerLengthY,
                  zLength=towerLengthZ);            
        }
    }    
}

module shaft(xLength, zLength)
{
    difference()
    {
        radius = 1.6;
        
        cylinder (h = RESISTOR_LEAD_LENGTH, 
                  r=1.6, 
                  $fn=100
        );
  
        rotate([55, 0, 0])  
        cube([4, 8, 1]
            , center=true            
        );
    }    
}

module shafts(xLength)
{
    for ( i = [0 : 1] )
    {
        centerPointSpacing = (xLength/2) + 5.5;
        xTranslate = (xLength/2.0) + i * ( xLength/2.0 + centerPointSpacing);
               
        color("blue")
        rotate([-15, 0, 0])
        translate([xTranslate,
                   0.5,
                   1])
        shaft(xLength, zLength);        
    }    
}

module tower(xLength, yLength, zLength)
{
    cube([xLength, yLength, zLength]);
}

module base(xLength, yLength, zLength)
{
    cube([xLength, yLength, zLength]);
}
