
use <../../../mounting-hardware/chain-loop/chain-loop.scad>

module rectangularDoughnut(cornerRadius = 4,
                           sides = 31,
                           yLength = 32,
                           zLength = 35)
{
    echo("cr1: ", cornerRadius);
    echo("yLength: ", yLength);
    echo("zLength: ", zLength);

    $fn=sides;

    minkowski()//size, cornerRadius)
    {
        chainLoop(xLength = 10,
                  yLength = yLength,
                  zLength = zLength,
                  zPercentage=0.64);

      	sphere(r=cornerRadius);

    };
}
    
