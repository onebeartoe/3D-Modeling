
/**
 * From the author on https://www.thingiverse.com/thing:2922028 :
 * 		"Each lampshade has seven rows of 24 tiles each; the tile rows are numbered
 * 		 from row 1 at the top to row 7 at the bottom."
 */

 yRotate = 4.5; // [0.1: 0.1 :30]
 xTranslate = -11.6; // [-120: 0.1 :130]
 zTranslate = -132.2; // [-220: 0.1 :130]

lampShade(latice_zTranslate = -140);

module lampShade(latice_zTranslate)
{
	color("black")
    translate([0, 0, latice_zTranslate])
    import("196-Lampshade_Lattice.stl");

    tileRow(color1 = "orange",
			color2 = "green",
			name = "196-Tile_1.stl",
			rotation = [0, 11.9, 0],
			translate = [-58.8, 0, -120]);

	tileRow(color1 = "red",
			color2 = "blue",
			name = "196-Tile_2.stl",
			rotation = [0, 6.4, 0],
			translate = [-30.1, 0, -129.5]);

	tileRow(color1 = "white",
			color2 = "white",
			name = "196-Tile_3.stl",
			rotation = [0, 6.4, 0],
			translate = [-27.8, 0, -129.5]);

	tileRow(color1 = "yellow",
			color2 = "yellow",
			name = "196-Tile_4.stl",
			rotation = [0, 5.9, 0],
			translate = [-23.0, 0, -129.5]);

	tileRow(color1 = "orange",
			color2 = "green",
			name = "196-Tile_5.stl",
			rotation = [0, 5.8, 0],
			translate = [-20.2, 0, -129.5]);

	tileRow(color1 = "red",
			color2 = "blue",
			name = "196-Tile_6.stl",
			rotation = [0, 4.6, 0],
			translate = [-13.6, 0, -131.3]);

	tileRow(color1 = "orange",
			color2 = "green",
			name = "196-Tile_7.stl",
			rotation = [0, 4.5, 0],
			translate = [-11.6, 0, -132.2]);
}

module tileRow(color1, color2, name, rotation, translate)
{
	tileCount = 24;

	for ( i = [0 : tileCount-1] )
	{
		zRotate = i * 360 / tileCount;

		color = i % 2 == 1 ? color1 : color2;

	    rotate([0, 0, zRotate])
		oneTile(color = color, name = name, rotate = rotation, translate = translate);
	}
}

module oneTile(color, name, rotate, translate)
{
    color(color)
    translate(translate)
    rotate(rotate)
    import(name);
}
