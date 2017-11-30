
use <../../coin.scad>;

module rotatedSpurCoin(innerIconXyScale = 0.4,
					   outerIconXyScale = 0.125,
					   outerIconTranslateY = 43,
					   radius = 55)
{
	coin(innerIcon = "Spur",
	    innerIconXyScale = innerIconXyScale,
	    outerIcon = "Spur",
	    outerIconCount = 10,
	    outerIconXyScale = outerIconXyScale,
		outerIconTranslateY = outerIconTranslateY,
	    radius = radius,
	    height=5);
}
