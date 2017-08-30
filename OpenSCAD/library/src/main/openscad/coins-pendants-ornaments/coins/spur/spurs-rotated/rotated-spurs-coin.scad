
use <../../coin.scad>;

module rotatedSpurCoin()
{
	coin(innerIcon = "Spur",
	    innerIconXyScale = 0.4,
	    outerIcon = "Spur",
	    outerIconCount = 10,
	    outerIconXyScale = 0.125,
	    radius = 55,
	    height=5);
}
