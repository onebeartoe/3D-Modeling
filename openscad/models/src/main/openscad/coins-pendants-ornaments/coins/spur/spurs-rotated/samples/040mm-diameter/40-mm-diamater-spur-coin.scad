
use <../../rotated-spurs-coin.scad>

module rotatedSpurCoin40mmDiameter()
{
	rotatedSpurCoin(innerIconXyScale = 0.134,
					outerIconCount = 7,
					outerIconXyScale = 0.04,
					outerIconTranslateY = 16,
					radius = 40/2.0);
}
