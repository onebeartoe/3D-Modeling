
use <../../../shapes/open-cylinder/open-cylinder.scad>

module waterPumpFilter(baseHeight = 30,
					   innerRadius = 25,
					   snorkel = false,
					   snorkelHeight = 40,
					   snorkelOuterRadius = 7,
					   xLength = 54)
{
	union()
	{
//		if(snorkel == true)
	//	{
		//	waterPump_snorkel(filter_baseHeight = baseHeight,
			//	 			  filter_xLength = xLength,
				//			  filter_yLength = yLength,
					//		  height = snorkelHeight,
						//	  snorkelOuterRadius = snorkelOuterRadius);
//		}

		zTranslate = baseHeight / 2.0;
		translate([0,0, zTranslate-0.1])
		waterPumpFilter_connector(innerRadius = innerRadius);


		yLength = (innerRadius * 2) + 4;
		waterPumpFilter_base(height = baseHeight,
							 innerRadius = innerRadius,
							 snorkel = snorkel,
							 snorkelOuterRadius = snorkelOuterRadius,
							 xLength = xLength,
							 yLength = yLength);
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
							snorkel,
							snorkelOuterRadius,
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

		waterPumpFilter_xCutouts(height = cutoutHeight,
								 length = xLength - 8);

		waterPumpFilter_yCutouts(height = cutoutHeight);

		if(snorkel == true)
		{
			waterPump_snorkel(filter_baseHeight = height,
							  filter_xLength = xLength,
							  filter_yLength = yLength,
							  height = 20,
							  snorkelOuterRadius = snorkelOuterRadius);
		}
	}
}

module waterPumpFilter_base_innerCube(xyLength, yLength, height)
{
	cube([xyLength, yLength, height], center = true);
}

module waterPump_snorkel(filter_baseHeight,
						 filter_xLength,
						 filter_yLength,
						 height,
						 snorkelOuterRadius)
{
	xTranslate = (filter_xLength / 2.0) - snorkelOuterRadius - 2;
	yTranslate = (filter_yLength / 2.0) - snorkelOuterRadius -2;
	zTranslate = (filter_baseHeight / 2.0) - 4;


	color("green")
	translate([xTranslate, yTranslate, zTranslate])
	cylinder(h = height, r = snorkelOuterRadius, fn = 50);
//	openCylinder(height = height,
	//			 innerRadius = snorkelOuterRadius - 2,
		//		 outerRadius = snorkelOuterRadius);

	translate([-xTranslate, -yTranslate, zTranslate])
// 	openCylinder(height = height,
 	//			 innerRadius = snorkelOuterRadius - 2,
 		//		 outerRadius = snorkelOuterRadius);
			 cylinder(h = height, r = snorkelOuterRadius, $fn = 100);
}

module waterPumpFilter_xCutouts(height, length)
{
	step = 5;

	for(x = [-length : step : length])
	{
		translate([x, 0, 0])
		cube([2, 100, height], center = true);
	}
}

module waterPumpFilter_yCutouts(height = 10, length = 20)
{
	step = 5;

	for(y = [-length : step : length])
	{
		translate([0, y, 0])
		cube([100, 2, height], center = true);
	}
}
