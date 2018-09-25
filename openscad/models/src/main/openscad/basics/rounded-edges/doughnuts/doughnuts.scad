
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

module roundDoughnut()
{
	minkowski()
	{
		openCylinder(height = 3,
						outerRadius = 7,
						innerRadius = 4.5,
						fn = 20);

		sphere(r=2, $fn = 10);
	}
}
