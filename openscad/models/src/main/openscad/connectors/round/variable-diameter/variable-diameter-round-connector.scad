
use <../../../shapes/open-cylinder/open-cylinder.scad>

module roundConnector(bottomHeight = 10,
					  middleHeight = 10,
					  middleOuterRadius = 15,
					  topHeight = 10)
{
	union()
	{
		color("teal")
		translate([0, 0, bottomHeight + middleHeight])
		roundConnector_top(height = topHeight);

		color("magenta")
		translate([0, 0, bottomHeight])
		roundConnector_middle(height = middleHeight,
							  outerRadius = middleOuterRadius);

		color("blue")
		roundConnector_Bottom(height = bottomHeight);
	}
}

module roundConnector_top(height)
{
	openCylinder(height = height);
}

module roundConnector_middle(height, outerRadius)
{
	openCylinder(height = height, outerRadius = outerRadius);
}

module roundConnector_Bottom(height)
{
	openCylinder(height = height);
}
