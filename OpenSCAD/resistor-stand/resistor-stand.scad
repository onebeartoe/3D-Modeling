
resisitorStand();

module resisitorStand()
{
    resistorHolder();
}

module resistorHolder(baseLengthX = 24,
                      baseLengthY = 15,
                      baseLengthZ = 5,
                      
                      towerLengthX = 6,
                      towerLengthY = 15,
                      towerLengthZ = 21)
{
    difference()
    {
        resistorHolderUnion(baseLengthX,
                      baseLengthY ,
                      baseLengthZ ,
                      
                      towerLengthX,
                      towerLengthY,
                      towerLengthZ);
                      
          shafts();
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
    cylinder (h = 130, 
              r=1.6, 
              $fn=100
    );    
}

module shafts()
{
    
}

module tower(xLength, yLength, zLength)
{
    difference()
    {
        cube([xLength, yLength, zLength]);
            
        color("blue")
        rotate([-20, 0, 0])
        translate([xLength,//xLength/2.0,
                   -1,
                   -10])
        shaft(xLength, zLength);
    }    
}

module base(xLength, yLength, zLength)
{
    cube([xLength, yLength, zLength]);
}
