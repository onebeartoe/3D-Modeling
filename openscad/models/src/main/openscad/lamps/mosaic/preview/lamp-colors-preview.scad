
/**
 * From the author on https://www.thingiverse.com/thing:2922028 :
 * 		"Each lampshade has seven rows of 24 tiles each; the tile rows are numbered
 * 		 from row 1 at the top to row 7 at the bottom."
 */

tile_yRotate = 11.9; // [0.1: 0.1 :30]
tile_xTranslate = -58.8; // [-120: 0.1 :130]
tile_zTranslate = -120; // [-120: 0.1 :130]

lampShade(latice_zTranslate = -140);

module lampShade(latice_zTranslate)
{

	color("black")
    translate([0, 0, latice_zTranslate])
    import("196-Lampshade_Lattice.stl");

    tile_rotate = [0, 11.9, 0];
	tile_translate = [-58.8, 0, -120];

    tileRow(color1 = "orange",
			color2 = "green",
			name = "196-Tile_1.stl",
			rotation = tile_rotate,
			translate = tile_translate);

	tileRow(color1 = "red",
			color2 = "blue",
			name = "196-Tile_2.stl",
			rotation = tile_rotate,
			translate = tile_translate);

	tileRow(color1 = "grey",
			color2 = "pink",
			name = "196-Tile_3.stl",
			rotation = tile_rotate,
			translate = tile_translate);


	tileRow(color1 = "yellow",
			color2 = "magenta",
			name = "196-Tile_4.stl",
			rotation = tile_rotate,
			translate = tile_translate);

	tileRow(color1 = "orange",
			color2 = "green",
			name = "196-Tile_5.stl",
			rotation = tile_rotate,
			translate = tile_translate);

	tileRow(color1 = "red",
			color2 = "blue",
			name = "196-Tile_6.stl",
			rotation = tile_rotate,
			translate = tile_translate);

	tileRow(color1 = "grey",
			color2 = "pink",
			name = "196-Tile_7.stl",
			rotation = tile_rotate,
			translate = tile_translate);
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
