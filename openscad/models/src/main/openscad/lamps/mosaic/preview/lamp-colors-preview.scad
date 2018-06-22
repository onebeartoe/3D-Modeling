
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

    tile1_rotate = [0, tile_yRotate, 0];
	tile1_translate = [tile_xTranslate, 0, tile_zTranslate];
    tileRow(color = "orange",
			name = "196-Tile_1.stl",
			rotation = tile1_rotate,
			translate = tile1_translate);
}

module tileRow(color, name, rotation, translate)
{
	tileCount = 24;

	for ( i = [0 : tileCount-1] )
	{
		zRotate = i * 360 / tileCount;

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
