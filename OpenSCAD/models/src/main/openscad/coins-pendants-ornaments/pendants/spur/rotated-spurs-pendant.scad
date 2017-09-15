

use <../../coins/spur/spurs-rotated/samples/55-mm-diamater/55-mm-diamater-spur-coin.scad>

use <../../../mounting-hardware/chain-loop/rounded/rounded-chain-loop.scad>

module rotatedSpur55mmDiameterPendant()
{
	union()
	{
		rotatedSpurCoin55mmDiameter();

		yTranslate = 55/2.0 + 4;
		zTranslate = -5/2.0;
		translate([0, yTranslate, zTranslate])
		roundedChainLoop(height = 5,
						 outerRadius = 5);
	 }
}
