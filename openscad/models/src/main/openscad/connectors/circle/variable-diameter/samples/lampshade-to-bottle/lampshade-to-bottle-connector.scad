
use <../../variable-diameter-round-connector.scad>

wallThickness = 2;

topHeight = 20;
tor = (31.5 / 2.0) - 0.25;
tir = tor - wallThickness;

bottomHeight = 20;
bor = (25.5 / 2.0) - 0;
bir = bor - wallThickness;

middleHeight = 5;
mor = tor + 1;
mir = bir;

union()
{
//	%
	color("red")
	lampAttachment();

	roundConnector(topHeight = topHeight,
				topInnerRadius = tir,
				topOuterRadius = tor,
				middleHeight = middleHeight,
				middleInnerRadius = mir,
				middleOuterRadius = mor,
				bottomHeight = bottomHeight,
				bottomInnerRadius = bir,
				bottomOuterRadius = bor);
}

module lampAttachment()
{
	height = 3;
	zTranslate = topHeight + middleHeight + bottomHeight - height;

	difference()
	{
		translate([0, 0, zTranslate])
		cylinder(h = height, r = tor, $fn = 100);

		cutoutRadius = 5.25;
		translate([0, 0, zTranslate - 0.1])
		cylinder(h = height + 2, r = cutoutRadius, $fn = 100);
	}
}
