
use <../../../shapes/open-cylinder/open-cylinder.scad>

module roundConnector(bottomHeight = 10,
					  bottomInnerRadius = 4.5,
					  bottomOuterRadius = 7,
					  middleHeight = 10,
					  middleInnerRadius = 4.5,
					  middleOuterRadius = 15,
					  topHeight = 10,
					  topInnerRadius = 4.5,
				  	  topOuterRadius = 7)
{
	union()
	{
		color("teal")
		translate([0, 0, bottomHeight + middleHeight])
		roundConnector_top(height = topHeight,
						   innerRadius = topInnerRadius,
						   outerRadius = topOuterRadius);

		color("magenta")
		translate([0, 0, bottomHeight])
		roundConnector_middle(height = middleHeight,
							  innerRadius = middleInnerRadius,
							  outerRadius = middleOuterRadius);

		color("blue")
		roundConnector_Bottom(height = bottomHeight,
							  innerRadius = bottomInnerRadius,
							  outerRadius = bottomOuterRadius);
	}
}

module roundConnector_top(height, innerRadius, outerRadius)
{
	openCylinder(height = height,
				 innerRadius = innerRadius,
				 outerRadius = outerRadius);
}

module roundConnector_middle(height, innerRadius, outerRadius)
{
	openCylinder(height = height,
				 innerRadius = innerRadius,
				 outerRadius = outerRadius);
}

module roundConnector_Bottom(height, innerRadius, outerRadius)
{
	openCylinder(height = height,
				 innerRadius = innerRadius,
				 outerRadius = outerRadius);
}
