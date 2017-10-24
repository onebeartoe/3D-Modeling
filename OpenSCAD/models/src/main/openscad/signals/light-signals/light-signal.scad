
use <../../external-resources/batman/batman.scad>

use <../../shapes/heart/heart.scad>
use <../../shapes/open-cylinder/open-cylinder.scad>

module lightSignal(baseHeight = 2,
				   icon1 = "",
				   icon1_scale = 1,
                   signalText1 = "",
				   stringText1_x,
	   			   stringText1_y,
			 	   signalText2 = "",
				   stringText2_x,
				   stringText2_y)
{
	difference()
	{
		lightSignal_shell(baseHeight, showOriginal = false);

		lightSignal_cutouts(icon1,
			icon1_scale,
							signalText1,
							stringText1_x,
							stringText1_y,
							signalText2, stringText2_x, stringText2_y);
	}
}

/** Support functions and moduules follow. **/

module lightSignal_cutouts(icon1,
							icon1_scale,
						   signalText1,
						   stringText1_x,
						   stringText1_y,
					 	   signalText2,
					   	   stringText2_x,
						   stringText2_y)
{
		lightSignal_textCutouts(signalText1,
								stringText1_x,
								stringText1_y,
								signalText2,
								stringText2_x,
	 						   	stringText2_y);

		lightSignal_iconCutouts(icon1, icon1_scale);
}

module lightSignal_iconCutouts(icon1, icon1_scale)
{
	if(icon1 == "")
	{
		// do nothing
	}
	else
	{
		zScale = 3;
		translate([0, 0, -1.01])
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

module lightSignal_shell(baseHeight,
									 showOriginal = false)
{
	signalStl = "../../../../../../../../../../../../Versioning/world/beto-land-world/3d-printing/super-heroes/batman/bat-signal/customizable_phone_bat_signal_20150130-9347-hv0ikc-0.stl";
	// DO NOT CHANGE THE RADIUS; IT MACHES THE ORIGINAL MODEL
	stlBaseInnerRadius = 18.5;
	stlBaseOuterRadius = stlBaseInnerRadius + 2.5;

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

//TODO: Move this module to the correct alphabetical location.
module lightSignal_oneTextCutout(text, x, y)
{
	if(text == "")
	{
		// do nothing
	}
	else
	{
/*echo("hi incons cutous");
echo(stringText2_x, stringText2_y);
echo("hi incons cutous");*/

		extrudeHeight = 6;
		zTranslate = -3;
		font = "Bauhaus 93:style=Regular";
		fontSize = 7.5;

		translate([x, y, zTranslate])
		linear_extrude(height = extrudeHeight)
		text(text, font = font, size = fontSize);
	}
}

module lightSignal_textCutouts(signalText1,
								stringText1_x,
								stringText1_y,
//TODO: Remove this initialization.
							    signalText2 = "",
							    stringText2_x,
							    stringText2_y)
{
	lightSignal_oneTextCutout(signalText1, stringText1_x, stringText1_y);

	lightSignal_oneTextCutout(signalText2, stringText2_x, stringText2_y);
}
