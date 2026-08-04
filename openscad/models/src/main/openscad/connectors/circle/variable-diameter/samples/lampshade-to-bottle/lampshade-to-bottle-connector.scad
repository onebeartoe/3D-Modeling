
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

roundConnector(topHeight = topHeight,
			   topInnerRadius = tir,
		  	   topOuterRadius = tor,
			   middleHeight = middleHeight,
			   middleInnerRadius = mir,
		  	   middleOuterRadius = mor,
               bottomHeight = bottomHeight,
			   bottomInnerRadius = bir,
			   bottomOuterRadius = bor);
