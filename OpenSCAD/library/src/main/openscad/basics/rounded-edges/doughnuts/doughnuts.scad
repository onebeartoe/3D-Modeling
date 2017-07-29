
use <../../../shapes/chain-loop/chain-loop.scad>

module rectangularDoughnut(cornerRadius=4,
                           cubeCentered=false,
                           sides=30, 
                           sidesOnly=false,
                           size=[20,20,2],
                           zLength = 35)
{
    $fn=sides;

    x = size[0] - cornerRadius/2;
    y = size[1] - cornerRadius/2;
    z = size[2];

    minkowski(size, cornerRadius)
    {
        chainLoop(xLength = 10,
                  yLength = 30,
                  zLength = zLength,
                  zPercentage=0.64319);
//        cube(size=[x,y,z], center=cubeCentered);

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