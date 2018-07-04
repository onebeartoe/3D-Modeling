
use <resources/196-Lampshade_Lattice.scad>
use <resources/196-Tile_1.scad>
use <resources/196-Tile_2.scad>
use <resources/196-Tile_3.scad>
use <resources/196-Tile_4.scad>
use <resources/196-Tile_5.scad>
use <resources/196-Tile_6.scad>
use <resources/196-Tile_7.scad>
use <resources/Lamp_Body_2.scad>

tile1Color1 = "red"; // [pink, red, black, white, yellow, blue, green]
tile1Color2 = "red"; // [pink, red, black, white, yellow, blue, green]

tile2Color1 = "red"; // [pink, red, black, white, yellow, blue, green]
tile2Color2 = "red"; // [pink, red, black, white, yellow, blue, green]

tile3Color1 = "red"; // [pink, red, black, white, yellow, blue, green]
tile3Color2 = "red"; // [pink, red, black, white, yellow, blue, green]

tile4Color1 = "red"; // [pink, red, black, white, yellow, blue, green]
tile4Color2 = "red"; // [pink, red, black, white, yellow, blue, green]

tile5Color1 = "red"; // [pink, red, black, white, yellow, blue, green]
tile5Color2 = "red"; // [pink, red, black, white, yellow, blue, green]

tile6Color1 = "red"; // [pink, red, black, white, yellow, blue, green]
tile6Color2 = "red"; // [pink, red, black, white, yellow, blue, green]

tile7Color1 = "red"; // [pink, red, black, white, yellow, blue, green]
tile7Color2 = "red"; // [pink, red, black, white, yellow, blue, green]

lampPreview(tile1Color1=tile1Color1);

module lampPreview()
{
    latice();

    tileRow(color1 = tile1Color1,
			color2 = tile1Color2,
			tileNumber=1);

	tileRow(color1 = tile2Color1,
			color2 = tile2Color2,
			tileNumber=2);

	tileRow(color1 = tile3Color1,
			color2 = tile3Color2,
			tileNumber=3);

	tileRow(color1 = tile4Color1,
			color2 = tile4Color2,
			tileNumber=4);

	tileRow(color1 = tile5Color1,
			color2 = tile5Color2,
			tileNumber=5);

	tileRow(color1 = tile6Color1,
			color2 = tile6Color2,
			tileNumber=6);

	tileRow(color1 = tile7Color1,
			color2 = tile7Color2,
			tileNumber=7);

	lampBody2();
}

module oneTile(color, tileNumber)
{
	color(color)
	if(tileNumber == 1)
	{
		tile1();
	}
	else if(tileNumber == 2)
	{
		tile2();
	}
	else if(tileNumber == 3)
	{
		tile3();
	}
	else if(tileNumber == 4)
	{
		tile4();
	}
	else if(tileNumber == 5)
	{
		tile5();
	}
	else if(tileNumber == 6)
	{
		tile6();
	}
	else if(tileNumber == 7)
	{
		tile7();
	}
}

module tileRow(color1, color2, tileNumber)
{
	tileCount = 24;

	for ( i = [0 : tileCount-1] )
	{
		zRotate = i * 360 / tileCount;

		color = i % 2 == 1 ? color1 : color2;

		rotate([0, 0, zRotate])
    	oneTile(color, tileNumber);
	}
}
