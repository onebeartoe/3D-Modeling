
use <../../../mounting-hardware/chain-loop/square/chain-loop.scad>
use <../../../shapes/open-cylinder/open-cylinder.scad>

module rectangularDoughnut(cornerRadius = 4,
                           sides = 31,
                           yLength = 32,
                           zLength = 35)
{
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

module roundDoughnut(fn = 20,
					 height = 3,
					 outerRadius = 7,
					 innerRadius = 4.5,
					 minkowskiSphereRadius = 2)
{
	minkowski()
	{
		openCylinder(height = height,
						outerRadius = outerRadius,
						innerRadius = innerRadius,
						fn = fn);

		sphere(r = minkowskiSphereRadius, $fn = 10);
//        sphere(r = minkowskiSphereRadius);//, $fn = 10);
	}
}
