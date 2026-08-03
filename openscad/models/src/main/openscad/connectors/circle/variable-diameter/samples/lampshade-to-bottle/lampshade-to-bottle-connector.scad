
use <../../variable-diameter-round-connector.scad>

wallThickness = 2;

tor = (31 / 2.0) - 0.5;
tir = tor - wallThickness;

bor = (25 / 2.0) - 0.5;
bir = bor - wallThickness;

mor = tor;
mir = bir;

roundConnector(topHeight = 20,
			   topInnerRadius = tir,
		  	   topOuterRadius = tor,
			   middleHeight = 5,
			   middleInnerRadius = mir,
		  	   middleOuterRadius = mor,
               bottomHeight = 20,
			   bottomInnerRadius = bir,
			   bottomOuterRadius = bor);
