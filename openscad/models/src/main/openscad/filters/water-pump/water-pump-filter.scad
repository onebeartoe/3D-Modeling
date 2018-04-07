
use <../../shapes/open-cylinder/open-cylinder.scad>

module waterPumpFilter(baseHeight = 30,
					   innerRadius = 25,
					   xLength = 54)
{
	union()
	{
		zTranslate = baseHeight / 2.0;
		translate([0,0, zTranslate-0.1])
		waterPumpFilter_connector(innerRadius = innerRadius);


		xyLength = (innerRadius * 2) + 4;
		waterPumpFilter_base(height = baseHeight,
							 innerRadius = innerRadius,
							 xLength = xLength,
							 yLength = xyLength);
	}
}

module waterPumpFilter_connector(innerRadius)
{
	openCylinder(height = 5,
				 innerRadius = innerRadius,
				 outerRadius = innerRadius + 2);
}

module waterPumpFilter_base(height,
														innerRadius,
														xLength,
														yLength)
{
	difference()
	{
		// this is the outer cube
		cube([xLength, yLength, height], center = true);

		color("pink")
		translate([0,0,10])
		cylinder(r=innerRadius, h=30, center=true);

		innerCubeDifference = 4;
		color("green")
		waterPumpFilter_base_innerCube(xLength - innerCubeDifference,
									   yLength - innerCubeDifference,
									   height - innerCubeDifference);

		cutoutHeight = height - 4;

		waterPumpFilter_xCutouts(height = cutoutHeight);

		waterPumpFilter_yCutouts(height = cutoutHeight);
	}
}

module waterPumpFilter_base_innerCube(xyLength, yLength, height)
{
	cube([xyLength, yLength, height], center = true);
}

module waterPumpFilter_xCutouts(height)
{
	step = 5;

	for(x = [-20 : step : 20])
	{
		translate([x, 0, 0])
		cube([2, 100, height], center = true);
	}
}

module waterPumpFilter_yCutouts(height)
{
	step = 5;

	for(y = [-20 : step : 20])
	{
		translate([0, y, 0])
		cube([100, 2, height], center = true);
	}
}
