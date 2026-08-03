
use <../../variable-diameter-round-connector.scad>

wallThickness = 3;

tir = 31 / 2.0;
tor = tir + wallThickness;

bir = 25 / 2.0;
bor = bir + wallThickness;

mir = bir + 0;

roundConnector(topHeight = 20,
			   topInnerRadius = tir,
		  	   topOuterRadius = tor,
			   middleHeight = 5,
			   middleInnerRadius = mir,
		  	   middleOuterRadius = tor,
               bottomHeight = 20,
			   bottomInnerRadius = bir,
			   bottomOuterRadius = bor);
