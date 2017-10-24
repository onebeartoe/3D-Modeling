
use <../../shapes/heart/heart.scad>
use <../../shapes/open-cylinder/open-cylinder.scad>

module lightSignal(baseHeight = 2,
				   icon1 = "none",
                   signalText1 = "Impalas",
			 	   signalText2 = "",
				   stringText2_x,
				   stringText2_y)
{
	difference()
	{
		lightSignal_shell(baseHeight, showOriginal = false);

		lightSignal_cutouts(icon1,
							signalText1,
							signalText2, stringText2_x, stringText2_y);
	}
}

/** Support functions and moduules follow. **/

module lightSignal_cutouts(icon1,
						   signalText1,
					 	   signalText2,
					   	   stringText2_x,
						   stringText2_y)
{
		lightSignal_textCutouts(signalText1,
								signalText2,
								stringText2_x,
	 						   	stringText2_y);

		lightSignal_iconCutouts(icon1);
}

module lightSignal_iconCutouts(icon1)
{
		if(icon1 != "none")
		{
				translate([0, 0, -1.01])
				if(icon1 == "heart")
				{
						scale([1, 1, 3])
						heartThumbnail();
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

module lightSignal_textCutouts(signalText1,
							   signalText2 = "", stringText2_x, stringText2_y)
{
	extrudeHeight = 6;
	zTranslate = -3;
	font = "Bauhaus 93:style=Regular";
	fontSize = 7.5;
	xTranslate = -18;
	translate([xTranslate, -3, zTranslate])
	linear_extrude(height = extrudeHeight)
	text(signalText1, font = font, size = fontSize);

	if(signalText2 == "")
	{
		// do nothing
	}
	else
	{
echo("hi incons cutous");
echo(stringText2_x, stringText2_y);
echo("hi incons cutous");

		translate([stringText2_x, stringText2_y, zTranslate])
		linear_extrude(height = extrudeHeight)
		text(signalText2, font = font, size = fontSize);
	}
}
