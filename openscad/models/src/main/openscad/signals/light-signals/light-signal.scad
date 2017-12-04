
use <../../external-resources/batman/batman.scad>

use <../../shapes/heart/heart.scad>
use <../../shapes/open-cylinder/open-cylinder.scad>

module lightSignal(baseHeight = 2,
                    icon1 = "",
                    icon1_scale = 1,
                    icon1_x = 0,
                    icon1_y = 0,
                    text1 = "",
                    text1_fontSize = 7.5,
                    text1_x = 0,
                    text1_y = 0,
                    text2 = "",
                    text2_fontSize = 7.5,
                    text2_x = 0,
                    text2_y = 0)
{
	difference()
	{
		lightSignal_shell(baseHeight, showOriginal = false);

		lightSignal_cutouts(icon1,
                                    icon1_scale,
                                    icon1_x,
                                    icon1_y,
                                    text1,
                                    text1_fontSize,
                                    text1_x,
                                    text1_y,
                                    text2,
                                    text2_fontSize,
                                    text2_x,
                                    text2_y);
	}
}

/** Support functions and moduules follow. **/

// DO NOT CHANGE THE RADIUS; IT MACHES THE ORIGINAL MODEL
function lightSignal_stlBaseInnerRadius() = 18.5;

function lightSignal_stlBaseOuterRadius() = lightSignal_stlBaseInnerRadius() + 2.5;

module lightSignal_cutouts(icon1,
                            icon1_scale,
                            icon1_x,
                            icon1_y,
                            text1,
                            text1_fontSize,
                            text1_x,
                            text1_y,
                            text2,
                            text2_fontSize,
                            text2_x,
                            text2_y)
{
		lightSignal_textCutouts(text1,
                                        text1_fontSize,
                                        text1_x,
                                        text1_y,
                                        text2,
                                        text2_fontSize,
                                        text2_x,
                                        text2_y);

		lightSignal_iconCutouts(icon1, icon1_scale, icon1_x,
		icon1_y);
}

module lightSignal_iconCutouts(icon1,
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
		if(icon1 == "heart")
		{
			scale([icon1_scale, icon1_scale, zScale])
			heartThumbnail();
		}
		else if(icon1 == "bat")
		{
			scale([icon1_scale, icon1_scale, zScale])
			batmanLogoThumbnail();
		}
	}
}

module lightSignal_oneTextCutout(text, fontSize, x, y)
{
	if(text == "")
	{
		// do nothing
	}
	else
	{
		extrudeHeight = 6;
		zTranslate = -3;
		fontName = "Bauhaus 93:style=Regular";

		translate([x, y, zTranslate])
		linear_extrude(height = extrudeHeight)
		text(text = text, font = fontName, size = fontSize);
	}
}

module lightSignal_shell(baseHeight,
                        showOriginal = false)
{
	signalStl = "../../../../../../../../../../../../Versioning/world/beto-land-world/3d-printing/super-heroes/batman/bat-signal/customizable_phone_bat_signal_20150130-9347-hv0ikc-0.stl";

	stlBaseInnerRadius = lightSignal_stlBaseInnerRadius();
	stlBaseOuterRadius = lightSignal_stlBaseOuterRadius();

	union()
	{
		// this is the top hole/cutout
		zTopHoleTranslate = 35;
		color("blue")
		translate([0, 0, zTopHoleTranslate])
		openCylinder(height=1, outerRadius = 12, innerRadius=6);

		// connector for the shaft and top hole
		color("pink")
		translate([0, 0, zTopHoleTranslate-3])
		openCylinder(height=3.1, outerRadius = 19, innerRadius=8);

		// this is the bottom wide shaft
		zTranslate = -baseHeight / 2.0;
		color("orange")
		translate([0, 0, zTranslate])
		openCylinder(height=zTopHoleTranslate, outerRadius = stlBaseOuterRadius, innerRadius = stlBaseInnerRadius);

		// this thing was modeld after this original
		if(showOriginal)
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

module lightSignal_textCutouts(text1,
								text1_fontSize,
								text1_x,
								text1_y,
							    text2,
								text2_fontSize,
							    text2_x,
							    text2_y)
{
	lightSignal_oneTextCutout(text1, text1_fontSize, text1_x, text1_y);

	lightSignal_oneTextCutout(text2, text2_fontSize, text2_x, text2_y);
}
