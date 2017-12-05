
use <../../shapes/dome/dome.scad>
use <../../shapes/open-cylinder/open-cylinder.scad>

use <../../thumbnails/thumbnails-by-name.scad>

module lightSignal(baseHeight = 2,
                    icon1 = "",
                    icon1_scale = 1,
                    icon1_x = 0,
                    icon1_y = 0,
                    icon2 = "",
                    icon2_scale = 1.0,
                    icon2_x = 0,
                    icon2_y = 0,
					mountingPosts = "No",
					mountingPostsTranslatePercentageZ = 0.6,
                    text1 = "",
					text1_fontName = "Bauhaus 93:style=Regular",
                    text1_fontSize = 7.5,
                    text1_x = 0,
                    text1_y = 0,
                    text2 = "",
					text2_fontName = "Bauhaus 93:style=Regular",
                    text2_fontSize = 7.5,
                    text2_x = 0,
                    text2_y = 0)
{
	difference()
	{
		showOriginal = "No";
		lightSignal_shell(baseHeight, mountingPosts, mountingPostsTranslatePercentageZ, showOriginal);

		lightSignal_cutouts(icon1,
                                    icon1_scale,
                                    icon1_x,
                                    icon1_y,
                                    icon2,
                                    icon2_scale,
                                    icon2_x,
                                    icon2_y,
                                    text1,
									text1_fontName,
                                    text1_fontSize,
                                    text1_x,
                                    text1_y,
                                    text2,
									text2_fontName,
                                    text2_fontSize,
                                    text2_x,
                                    text2_y);
	}
}

/** Support functions and moduules follow. **/

function lightSignal_mountingPostRadius() = 3;

// DO NOT CHANGE THE RADIUS; IT MACHES THE ORIGINAL MODEL
function lightSignal_stlBaseInnerRadius() = 18.5;

function lightSignal_stlBaseOuterRadius() = lightSignal_stlBaseInnerRadius() + 2.5;

module lightSignal_cutouts(icon1,
                            icon1_scale,
                            icon1_x,
                            icon1_y,
                            icon2,
                            icon2_scale,
                            icon2_x,
                            icon2_y,
                            text1,
							text1_fontName,
                            text1_fontSize,
                            text1_x,
                            text1_y,
                            text2,
							text2_fontName,
                            text2_fontSize,
                            text2_x,
                            text2_y)
{
		lightSignal_textCutouts(text1,
								text1_fontName,
                                text1_fontSize,
                                text1_x,
                                text1_y,
                                text2,
								text2_fontName,
                                text2_fontSize,
                                text2_x,
                                text2_y);

		lightSignal_iconCutouts(icon1,
                                icon1_scale,
                                icon1_x,
                                icon1_y,
                                icon2,
                                icon2_scale,
                                icon2_x,
                                icon2_y);
}

module lightSignal_iconCutouts(icon1,
                                icon1_scale,
                                icon1_x,
                                icon1_y,
                                icon2,
                                icon2_scale,
                                icon2_x,
                                icon2_y)
{
    lightSignal_oneIconCutout(icon1,
                                icon1_scale,
                                icon1_x,
                                icon1_y);

    lightSignal_oneIconCutout(icon2,
                                icon2_scale,
                                icon2_x,
                                icon2_y);
}

module lightSignal_oneIconCutout(
                    icon1,
                    icon1_scale,
                    icon1_x,
                    icon1_y)
{
    if(icon1 == "")
    {
        // do nothing
    }
    else
    {
        zScale = 3;
        translate([icon1_x, icon1_y, -1.01])
		scale([icon1_scale, icon1_scale, zScale])
        thumbnailByName(icon1);
    }
}

// TODO: Move this model back here!
//module lightSignal_oneShellMountingPost()

module lightSignal_oneTextCutout(text, fontName, fontSize, x, y)
{
    if(text == "")
    {
        // do nothing
    }
    else
    {
        extrudeHeight = 6;
        zTranslate = -3;
//echo("fontName", fontName);
        translate([x, y, zTranslate])
        linear_extrude(height = extrudeHeight)
        text(text = text, font = fontName, size = fontSize);
    }
}

module lightSignal_shell(baseHeight,
							mountingPosts,
							mountingPostsTranslatePercentageZ,
	                    	showOriginal)
{
	signalStl = "../../../../../../../../../../../../Versioning/world/beto-land-world/3d-printing/super-heroes/batman/bat-signal/customizable_phone_bat_signal_20150130-9347-hv0ikc-0.stl";

	stlBaseInnerRadius = lightSignal_stlBaseInnerRadius();
	stlBaseOuterRadius = lightSignal_stlBaseOuterRadius();

	union()
	{
		// this is the top hole/cutout
		zTopHoleTranslate = 35;
/*
		color("blue")
		translate([0, 0, zTopHoleTranslate])
		openCylinder(height=1, outerRadius = 12, innerRadius=6);

		// connector for the shaft and top hole
		color("pink")
		translate([0, 0, zTopHoleTranslate-3])
		openCylinder(height=3.1, outerRadius = 19, innerRadius=8);
*/
//------------
		color([1,0.6863,0.6863])
		translate([0,0,13.5])
		difference()
		{
			dome(domePercentage=50, radius=30.0);

			openCylinder(height=35, innerRadius=21.0, outerRadius=51.0);

			translate([0,0,31])
			cylinder(h=9, r=6, center=true);

		}
//------------

		if(mountingPosts == "Yes")
		{
			lightSignal_shellMountingPosts(zTopHoleTranslate, mountingPostsTranslatePercentageZ);
		}

		// this is the bottom wide shaft
		zTranslate = -baseHeight / 2.0;
		color("yellow")
		translate([0, 0, zTranslate])
		openCylinder(height=zTopHoleTranslate, outerRadius = stlBaseOuterRadius, innerRadius = stlBaseInnerRadius);

		// this thing was modeld after this original
		if(showOriginal == "Yes")
		{
			color("yellow")
			translate([0, 0, zTranslate])
			import(signalStl);
		}

		// This is the bottom disk, that holds the text/icon cutout.
		color("green")
		cylinder(r=stlBaseInnerRadius+0.1, h=baseHeight, center=true);
	}
}

// TODo: Move this module to the correct ABC location
module lightSignal_oneShellMountingPost()
{
	radius = lightSignal_mountingPostRadius();
	height = 10;
//	translate([height, 0, 0])
	rotate([0, 90, 0])
	cylinder(r=radius, h=height, center=true, $fn=20);
}

module lightSignal_shellMountingPosts(zTopHoleTranslate, zTranslatePercentage)
{
	xTranslate = lightSignal_stlBaseOuterRadius() + 2.5;
	zTranslate = zTopHoleTranslate * zTranslatePercentage;
	translate([xTranslate, 0, zTranslate])
	lightSignal_oneShellMountingPost();

//	zTranslate = zTopHoleTranslate * 0.75;
	translate([-xTranslate, 0, zTranslate])
	lightSignal_oneShellMountingPost();
}

module lightSignal_textCutouts(text1,
								text1_fontName,
                                text1_fontSize,
                                text1_x,
                                text1_y,
                                text2,
								text2_fontName,
                                text2_fontSize,
                                text2_x,
                                text2_y)
{
    lightSignal_oneTextCutout(text1, text1_fontName, text1_fontSize, text1_x, text1_y);

    lightSignal_oneTextCutout(text2, text2_fontName, text2_fontSize, text2_x, text2_y);
}
