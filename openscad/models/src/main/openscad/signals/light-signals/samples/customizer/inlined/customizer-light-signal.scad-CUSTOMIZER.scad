

// preview[view:south, tilt:bottom]
/**
	preview[view:south east, tilt:bottom diagonal] - meh
	preview[view:south, tilt:bottom diagonal]      - okay
	preview[view:south east, tilt:bottom diagonal] - nope
**/

text1 = "Impalas";
text1_fontName = "Bauhaus 93"; // [Allerta Stencil, Bauhaus 93, Black Ops One, Emblema One, Kenia, Plaster, SirinStencil, Stardos Stencil, Trocchi Bold-Stencil, Wallpoet]
text1_x = -18;
text1_y = -3;

mountingPosts = "Yes"; // [Yes, No]

lightSignal(mountingPosts = mountingPosts,
            text1 = text1,
			text1_fontName = text1_fontName,
            text1_x = text1_x,
            text1_y = text1_y);



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

module dome(radius = 15, shellThickness = 2, domePercentage = 100)
{
    difference()
    {
        sphere(r = radius);

        innerRadius = (radius - shellThickness);
        sphere(r = innerRadius);

        zTranslate = -radius * domePercentage/100;
        translate([0, 0, zTranslate])
        cube(radius*2, center=true);
    }
}

// // TODO: Lower this to 50.
module openCylinder(height = 3,
                    outerRadius = 7,
                    innerRadius = 4.5,
                    fn = 100)
{
    $fn = fn;

    difference()
    {
        cylinder(r=outerRadius,
                 h=height);

        translate([0, 0, -1])
        cylinder(r=innerRadius,
                 h=height+1.01);
    }
}


module thumbnailByName(iconName)
{
	if(iconName == "arrow")
	{
		shapes_thumbnailByName(iconName);
	}
	else if(iconName == "dialog-bubble")
	{
		shapes_thumbnailByName(iconName);
	}
	else if(iconName == "heart")
	{
		shapes_thumbnailByName(iconName);
	}
	else if(iconName == "bat")
	{
		externalResources_thumbnailByName(iconName);
	}
	else if(iconName == "spur")
	{
		shapes_thumbnailByName(iconName);
	}
	else
	{
		echo("No thumbnail was found.");
	}
}


module externalResources_thumbnailByName(iconName)
{
	if(iconName == "bat")
	{
	//                scale([icon1_scale, icon1_scale, zScale])
			batmanLogoThumbnail();
	}
	else if(iconName == "jflkdfjaldsjfdsfjasbat")
	{
	//                scale([icon1_scale, icon1_scale, zScale])
			fjlkajfkjfldsThumbnail();
	}
}


module shapes_thumbnailByName(iconName)
{
	if(iconName == "arrow")
	{
		rightArrowThumbnail();
	}
	else if(iconName == "dialog-bubble")
	{
		stenciledDialogBubbleThumbnail();
	}
	else if(iconName == "heart")
	{
	//                scale([icon1_scale, icon1_scale, zScale])
			heartThumbnail();
	}
	else if(iconName == "spur")
	{
			spurThumbnail();
	}
	else
	{
		echo("No shape thumbnail was found");
	}
}

module batmanLogo(height=1)
{
//    color([0.15,0.15,0.15])
    color("blue")
    linear_extrude(height = height, center = true, convexity = 10, twist = 0)
    difference()
    {
        
        translate([0,20,0])
        polygon(points=[[-9.8, -14], [9.8,-14],[3.8, 14],[-3.8, 14] ],paths=[[0,1,2,3]], convexity=10);
    
        translate([0,30,0])
        polygon(points=[[-2, -8], [2,-8],[12, 8],[-12, 8] ],paths=[[0,1,2,3]], convexity=10);
    }
    
//    color([0.15,0.15,0.15])
    color("blue")
    linear_extrude(height = height, center = true, convexity = 10, twist = 0)
    difference()
    {
        projection(cut=true) 
        rotate([0,50,0])
        cylinder(r=30, h=200, center=true);
    
        translate([-8,-23,0]) 
        rotate([0,0,-60])
        projection(cut=true)
        rotate([0,62,0])
        cylinder(r=7, h=200, center=true);
    
        translate([8,-23,0]) 
        rotate([0,0,60])
        projection(cut=true)
        rotate([0,62,0])
        cylinder(r=7, h=200, center=true);
    
        translate([-18,-24,0]) 
        rotate([0,0,-50])
        projection(cut=true)
        rotate([0,67,0])
        cylinder(r=7, h=200, center=true);
    
        translate([18,-24,0]) 
        rotate([0,0,50])
        projection(cut=true)
        rotate([0,67,0])
        cylinder(r=7, h=200, center=true);
    
        union()
        {
    
            translate([-7,25,0]) 
            rotate([0,0,30])
            projection(cut=true)
            rotate([0,45,0])
            cylinder(r=13, h=200, center=true);
    
            translate([7,25,0]) 
            rotate([0,0,-30])
            projection(cut=true)
            rotate([0,45,0])
            cylinder(r=13, h=200, center=true);
        }
    }
}

//TODO: make this a proper thumbnail using thumbnail-background.scad
module batmanLogoThumbnail()
{
    xyScale = 0.27;
    translate([0.4, -0.3, 0])
    scale([xyScale, xyScale, 2.78])	
    batmanLogo();
}


module arrow()
{
    union()
    {
        triangle(size = 5);

        xLength = 2;
        yLength = 10;
        xTranslate = -xLength / 2.0;
        yTranslate = -yLength;
        translate([xTranslate, yTranslate, 0])
        cube([xLength, yLength, 1]);
    }
}

module arrowThumbnail()
{
    xyScale = 1.62;
    yTranslate = 4.05;
    translate([0, yTranslate, 0])
    scale([xyScale, xyScale, 1])
    arrow();
}

module rightArrowThumbnail()
{
    rotate([0, 0, -90])
    arrowThumbnail();
}


module stencilDialogBubble()
{
	difference()
	{
		yLength = 15;

		dialogBubble(yLength = yLength);

		stencilDialogBubble_lines(yLength);
	}
}

module stenciledDialogBubbleThumbnail()
{
	xyScale = 0.62134;
	scale([xyScale, xyScale, 1])
	stencilDialogBubble();
}

/** Support functions and modules follow. **/

module stencilDialogBubble_lines(yLength)
{
	xLength = 100;
	xTranslate = -yLength - 15;
	translate([xTranslate, 0, -0.2])
	scale([1,1,2])
	union()
	{
		// horizontal 0
		translate([0,10,0])
		cube([xLength, 1, 1]);

		// horizontal 1
		cube([xLength, 1, 1]);

		// horizontal 2
		translate([0,-10,0])
		cube([xLength, 1, 1]);
	}
}

module heart(height=1)
{
echo("hearto");
    rotate ([0, 0, 45])
    linear_extrude(height=height)
    flatHeart();
}

module heartThumbnail(height=1)
{	
    xyScale = 0.725;
    translate([0, -1.5, 0])
    scale([xyScale, xyScale, 1])
    heart(height);
}

module flatHeart()
{
    square(20, center = true);

    translate([10,0,0])	
    circle(10, center = true, color="red" );

    translate([0,10,0]) 
    circle(10, center = true);
}

// Module names are of the form poly_<inkscape-path-id>().  As a result,
// you can associate a polygon in this OpenSCAD program with the corresponding
// SVG element in the Inkscape document by looking for the XML element with
// the attribute id="inkscape-path-id".

module spur(zLength)
{
  scale([25.4/90, -25.4/90, 2])
  translate([0, 0, -2])
//  union()
  {
    linear_extrude(height = zLength)
    polygon([[13.500000,-56.000000],[29.500000,-55.000000],[54.500000,-55.000000],[58.503750,-55.048750],[60.522969,-55.341719],[62.290000,-56.020000],[64.325156,-57.853594],[66.241250,-60.541250],[69.240000,-66.000000],[80.500000,-87.000000],[106.280000,-135.000000],[118.870000,-159.000000],[122.780000,-198.000000],[124.023594,-204.882813],[125.843750,-209.652500],[128.457031,-214.095937],[132.080000,-220.000000],[148.490000,-248.000000],[153.376719,-256.487656],[155.041895,-259.143652],[156.518750,-260.956250],[158.055137,-262.086816],[159.898906,-262.696719],[165.500000,-263.000000],[214.500000,-263.000000],[214.500000,-213.000000],[213.360000,-196.000000],[213.360000,-154.000000],[213.495000,-150.462500],[213.360000,-147.000000],[196.920000,-117.000000],[156.350000,-45.000000],[125.920000,9.000000],[120.671250,18.592500],[117.385469,23.577187],[115.794199,25.366055],[114.320000,26.400000],[112.797344,26.797500],[110.981250,26.970000],[107.500000,27.000000],[79.500000,27.000000],[65.500000,28.000000],[31.500000,28.000000],[27.943750,28.030000],[24.500000,28.600000],[22.684180,29.597539],[20.548438,31.277812],[15.792500,35.922500],[7.670000,45.000000],[-36.500000,94.040000],[-25.500000,94.040000],[-15.500000,95.000000],[1.500000,95.000000],[22.500000,96.000000],[2.500000,114.080000],[-38.500000,149.000000],[-23.230000,165.000000],[-3.230000,188.000000],[14.500000,210.000000],[-66.500000,189.000000],[-91.500000,263.000000],[-92.970664,261.624141],[-94.426562,259.592500],[-97.197500,254.302500],[-101.500000,244.000000],[-121.500000,198.000000],[-200.500000,222.000000],[-174.840000,182.000000],[-154.500000,151.000000],[-187.500000,128.020000],[-214.500000,108.000000],[-166.500000,103.830000],[-135.500000,101.000000],[-137.410000,77.000000],[-139.590000,41.000000],[-140.500000,31.000000],[-138.108496,32.343340],[-135.722969,34.055469],[-131.038750,38.223750],[-122.500000,47.000000],[-111.500000,57.040000],[-94.500000,74.000000],[-77.500000,27.000000],[-107.500000,26.000000],[-117.196250,25.451250],[-122.812656,24.814531],[-126.090000,23.980000],[-127.513906,22.488438],[-128.773750,20.335000],[-130.730000,16.000000],[-138.200000,-1.000000],[-140.195000,-5.868750],[-140.649688,-8.406719],[-140.330000,-11.000000],[-134.780000,-21.000000],[-120.780000,-45.000000],[-74.650000,-124.000000],[-55.110000,-158.000000],[-46.570000,-206.000000],[-30.280000,-238.000000],[-21.920000,-254.000000],[-19.818750,-257.793750],[-18.535156,-259.646094],[-17.110000,-260.980000],[-15.251406,-261.684844],[-12.943750,-261.983750],[-8.500000,-261.990000],[5.500000,-261.000000],[19.500000,-261.000000],[31.500000,-260.040000],[43.500000,-260.040000],[43.500000,-217.000000],[44.500000,-200.000000],[44.500000,-162.000000],[43.800000,-154.000000],[28.100000,-127.000000],[-14.500000,-56.000000],[13.500000,-56.000000]]);
  }
}

module spurThumbnail(height = 1)
{
    xyScale = 0.164;
    translate([0,0,4])
    scale([xyScale, xyScale, 1])
    spur(zLength = height);
}

module triangle(size=1, height=1)
{
    rotate([0, 0, 90])
    cylinder(r=size, 
             $fn=3,
             h=height);
}

use <MCAD/triangles.scad>
//use <MCAD/shapes.scad>


module dialogBubble(pointerRotateZ = 25,
					yLength = 10)
{
	difference()
	{
		dialogBubble_block(pointerRotateZ, yLength);

		dialogBubble_cutouts(pointerRotateZ, yLength);
	}

//	dialogBubble_cutouts(pointerRotateZ, yLength);
}

/** Support functions and modules follow.  **/

module dialogBubble_block(pointerRotateZ, yLength)
{
	union()
	{
//		% // transparent
		openOval(borderThickness = 1.5,
				 yLength = yLength);

		dialogBubble_pointer(pointerRotateZ, yLength);
	}
}

module dialogBubble_cutouts(pointerRotateZ, yLength)
{

	translate([-3.1, 3.5, -0.1])
	scale([1, 1, 1.4])
	dialogBubble_pointer(pointerRotateZ, yLength);
}

module dialogBubble_pointer(pointerRotateZ, yLength)
{
	yTranslate = -5;
	yTranslate = -yLength + 5;
	rotateZ = pointerRotateZ;
	translate([15, yTranslate, 0])
	rotate([0, 0, rotateZ])
	triangle(o_len = -8, a_len = -5, depth=1);
}

use <MCAD/shapes.scad>
//use </usr/share/openscad/libraries/MCAD/shapes.scad>
//use </Applications/OpenSCAD.app/Contents/Resources/libraries/MCAD/shapes.scad>

module openOval(borderThickness = 3, yLength = 10, zLength = 1)
{
	openOval2d(borderThickness = borderThickness,
			   depth = zLength,
			   height = yLength);
}

/** Support functions and modules follow.  **/

module openOval2d(borderThickness = 3,
				  depth = 5,
				  height = 10,
				  width = 20)
{
	difference()
	{
		ellipticalCylinder(w = width, h = height, height = depth);

		w = width - borderThickness;
		h = height - borderThickness;
		translate([0, 0, -0.02])
		ellipticalCylinder(w = w, h = h, height = depth + 0.1);
	}
}