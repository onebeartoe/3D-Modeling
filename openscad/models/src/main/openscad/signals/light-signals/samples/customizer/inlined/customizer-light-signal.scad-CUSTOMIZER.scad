

// preview[view:south, tilt:bottom]
/**
	preview[view:south east, tilt:bottom diagonal] - meh
	preview[view:south, tilt:bottom diagonal]      - okay
	preview[view:south east, tilt:bottom diagonal] - nope
**/

text1 = "";
text1_fontName = "Bauhaus 93"; // [Allerta Stencil, Bauhaus 93, Black Ops One, Emblema One, Kenia, Plaster, SirinStencil, Stardos Stencil, Trocchi Bold-Stencil, Wallpoet]
text1_x = -18;
text1_y = -3;

mountingPosts = "Yes"; // [Yes, No]

lightSignal(icon1 = "rebel",
			mountingPosts = mountingPosts,
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
	else if(iconName == "rebel")
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
	else if(iconName == "rebel")
	{
		rebelAllianceThumbnail();
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

// Module names are of the form poly_<inkscape-path-id>().  As a result,
// you can associate a polygon in this OpenSCAD program with the corresponding
// SVG element in the Inkscape document by looking for the XML element with
// the attribute id="inkscape-path-id".

// fudge value is used to ensure that subtracted solids are a tad taller
// in the z dimension than the polygon being subtracted from.  This helps
// keep the resulting .stl file manifold.
fudge = 0.1;

module rebelAlliance(h=1)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-140.090000,-711.580000],[-168.890000,-761.580000],[-175.158750,-770.355000],[-177.866094,-775.380938],[-178.460449,-777.642539],[-178.300000,-779.580000],[-176.323281,-782.664844],[-172.671250,-787.076250],[-165.910000,-794.580000],[-141.260000,-822.580000],[-46.120000,-930.580000],[-15.260000,-965.580000],[-9.823750,-971.838750],[-6.461094,-975.014531],[-3.750000,-976.380000],[-0.790781,-975.056719],[2.591250,-971.951250],[8.160000,-965.580000],[37.210000,-932.580000],[132.310000,-824.580000],[159.580000,-793.580000],[165.318750,-787.233750],[168.227031,-783.560469],[169.760000,-780.580000],[168.965313,-776.953438],[166.357500,-772.050000],[160.840000,-763.580000],[137.270000,-720.580000],[122.320000,-687.783281],[109.305000,-654.188750],[103.666094,-637.090254],[98.682500,-619.789844],[94.411406,-602.286699],[90.910000,-584.580000],[86.740000,-555.580000],[85.621250,-545.956250],[85.526406,-540.967656],[86.160000,-536.580000],[91.107500,-545.540938],[98.770000,-556.030000],[114.080000,-574.580000],[124.538477,-586.564258],[135.531562,-598.184063],[158.867500,-620.312500],[183.579687,-640.929688],[209.160000,-660.000000],[242.160000,-681.180000],[249.055000,-685.315000],[253.030312,-687.173438],[256.160000,-687.710000],[258.689531,-686.539531],[261.163750,-684.353750],[265.320000,-679.580000],[285.000000,-657.580000],[339.230000,-596.580000],[356.160000,-577.580000],[362.718750,-570.368750],[365.836406,-566.427031],[368.160000,-562.580000],[357.375859,-558.414766],[346.266875,-553.353750],[323.815000,-541.187500],[302.285625,-527.367500],[283.160000,-513.180000],[269.431836,-501.715566],[256.181563,-489.647031],[243.460508,-476.992793],[231.320000,-463.771250],[219.811367,-450.000801],[208.985937,-435.699844],[198.895039,-420.886777],[189.590000,-405.580000],[179.976875,-387.207969],[171.365000,-367.893750],[163.675625,-348.172656],[156.830000,-328.580000],[148.449844,-301.275781],[141.373750,-273.661250],[135.540781,-245.756094],[130.890000,-217.580000],[126.070000,-169.580000],[125.160000,-157.580000],[125.160000,-112.580000],[126.070000,-100.580000],[130.910000,-56.580000],[134.238149,-38.871221],[138.342695,-21.206797],[143.251909,-3.690850],[148.994063,13.572500],[155.597427,30.479131],[163.090273,46.924922],[171.500874,62.805752],[180.857500,78.017500],[191.188423,92.456045],[202.521914,106.017266],[214.886245,118.597041],[228.309688,130.091250],[242.820513,140.395771],[258.446992,149.406484],[275.217397,157.019268],[293.160000,163.130000],[315.028750,167.990000],[326.818594,169.694375],[337.160000,170.420000],[359.307383,169.551621],[380.936562,166.534844],[402.035586,161.539707],[422.592500,154.736250],[442.595352,146.294512],[462.032188,136.384531],[480.891055,125.176348],[499.160000,112.840000],[520.271250,96.973750],[531.499531,87.964844],[540.160000,80.380000],[553.044219,67.199219],[566.126250,52.401250],[578.692656,37.102656],[590.030000,22.420000],[610.259473,-6.374434],[628.792656,-36.459219],[645.531699,-67.682832],[660.378750,-99.893750],[673.235957,-132.940449],[684.005469,-166.671406],[692.589434,-200.935098],[698.890000,-235.580000],[703.250000,-278.580000],[704.160000,-290.580000],[704.160000,-339.580000],[703.250000,-349.580000],[698.430000,-395.580000],[695.232402,-415.143770],[691.295469,-434.775156],[686.665488,-454.395527],[681.388750,-473.926250],[675.511543,-493.288691],[669.080156,-512.404219],[654.740000,-549.580000],[637.470000,-587.580000],[626.562285,-609.956113],[614.280781,-632.755156],[600.879199,-655.711934],[586.611250,-678.561250],[571.730645,-701.037910],[556.491094,-722.876719],[525.950000,-763.580000],[493.070000,-803.580000],[490.134844,-806.846719],[486.733750,-811.518750],[485.844902,-813.644355],[486.023281,-815.236406],[487.663457,-815.999941],[491.160000,-815.640000],[496.848750,-813.647813],[502.207500,-810.622500],[512.160000,-803.430000],[545.160000,-778.950000],[578.029844,-753.726875],[610.261250,-727.675000],[641.692031,-700.678125],[672.160000,-672.620000],[701.120000,-644.580000],[720.731309,-623.489277],[739.709219,-601.861719],[758.018457,-579.692988],[775.623750,-556.978750],[792.489824,-533.714668],[808.581406,-509.896406],[823.863223,-485.519629],[838.300000,-460.580000],[856.918223,-424.955527],[873.757656,-388.501719],[888.874199,-351.311738],[902.323750,-313.478750],[914.162207,-275.095918],[924.445469,-236.256406],[933.229434,-197.053379],[940.570000,-157.580000],[944.501562,-132.125000],[947.842500,-106.677500],[953.330000,-55.580000],[956.840000,-4.580000],[956.160000,5.420000],[956.160000,20.420000],[955.160000,34.420000],[953.250000,66.420000],[951.004844,94.030625],[948.068750,121.555000],[944.470781,149.011875],[940.240000,176.420000],[933.811047,211.725286],[926.243691,246.805410],[917.533435,281.612400],[907.675781,316.098281],[896.666233,350.215081],[884.500293,383.914824],[871.173464,417.149539],[856.681250,449.871250],[841.019153,482.031985],[824.182676,513.583770],[806.167322,544.478630],[786.968594,574.668594],[766.581995,604.105686],[745.003027,632.741934],[722.227195,660.529363],[698.250000,687.420000],[656.160000,730.330000],[633.958083,750.351604],[611.220137,769.549395],[587.957864,787.918464],[564.182969,805.453906],[539.907156,822.150813],[515.142129,838.004277],[489.899592,853.009392],[464.191250,867.161250],[438.028806,880.454944],[411.423965,892.885566],[384.388430,904.448210],[356.933906,915.137969],[329.072097,924.949934],[300.814707,933.879199],[272.173440,941.920857],[243.160000,949.070000],[210.345781,956.090156],[178.001250,961.948750],[145.486094,966.747969],[112.160000,970.590000],[74.160000,973.510000],[64.160000,974.420000],[46.160000,975.420000],[26.160000,975.420000],[9.160000,976.380000],[-7.840000,976.380000],[-17.840000,975.420000],[-36.840000,975.420000],[-55.840000,974.420000],[-65.840000,973.510000],[-109.941250,969.558750],[-153.840000,963.500000],[-181.026191,958.615820],[-208.065781,952.980938],[-234.934043,946.588086],[-261.606250,939.430000],[-288.057676,931.499414],[-314.263594,922.789062],[-340.199277,913.291680],[-365.840000,903.000000],[-390.045730,892.449340],[-413.868069,881.279253],[-437.298800,869.500076],[-460.329707,857.122148],[-482.952575,844.155807],[-505.159187,830.611392],[-526.941328,816.499239],[-548.290781,801.829687],[-569.199331,786.613076],[-589.658762,770.859741],[-609.660858,754.580023],[-629.197402,737.784258],[-648.260180,720.482785],[-666.840974,702.685942],[-684.931570,684.404068],[-702.523750,665.647500],[-719.609300,646.426577],[-736.180002,626.751636],[-752.227643,606.633016],[-767.744004,586.081055],[-782.720871,565.106091],[-797.150027,543.718462],[-811.023257,521.928506],[-824.332344,499.746562],[-837.069073,477.182968],[-849.225227,454.248062],[-860.792591,430.952181],[-871.762949,407.305664],[-882.128085,383.318849],[-891.879783,359.002075],[-901.009826,334.365679],[-909.510000,309.420000],[-922.527812,266.043437],[-933.425000,222.342500],[-942.267188,178.180313],[-949.120000,133.420000],[-954.880000,73.420000],[-955.840000,62.420000],[-956.840000,42.420000],[-956.840000,-27.580000],[-955.840000,-47.580000],[-954.930000,-57.580000],[-951.086250,-100.166250],[-945.420000,-142.580000],[-940.506765,-171.172578],[-934.683027,-199.589375],[-927.963362,-227.806484],[-920.362344,-255.800000],[-911.894548,-283.546016],[-902.574551,-311.020625],[-892.416926,-338.199922],[-881.436250,-365.060000],[-869.647097,-391.576953],[-857.064043,-417.726875],[-843.701663,-443.485859],[-829.574531,-468.830000],[-814.697224,-493.735391],[-799.084316,-518.178125],[-782.750383,-542.134297],[-765.710000,-565.580000],[-746.478594,-590.558750],[-726.466250,-615.035000],[-705.608281,-638.783750],[-683.840000,-661.580000],[-649.840000,-695.490000],[-624.482969,-718.357344],[-598.513750,-740.383750],[-571.957656,-761.703281],[-544.840000,-782.450000],[-509.840000,-806.910000],[-505.204844,-810.186719],[-500.958750,-812.821250],[-496.403281,-814.167656],[-490.840000,-813.580000],[-493.135937,-808.834063],[-496.292500,-804.547500],[-503.410000,-796.580000],[-527.370000,-766.580000],[-545.513594,-741.598750],[-562.906250,-716.077500],[-579.543281,-690.057500],[-595.420000,-663.580000],[-613.111660,-631.683555],[-629.933906,-598.377813],[-645.653887,-563.941914],[-660.038750,-528.655000],[-672.855645,-492.796211],[-683.871719,-456.644688],[-692.854121,-420.479570],[-699.570000,-384.580000],[-705.930000,-326.580000],[-706.840000,-314.580000],[-706.840000,-266.580000],[-705.930000,-256.580000],[-702.110000,-218.580000],[-698.663379,-197.623223],[-694.453281,-177.287656],[-689.460605,-157.452949],[-683.666250,-137.998750],[-677.051113,-118.804707],[-669.596094,-99.750469],[-661.282090,-80.715684],[-652.090000,-61.580000],[-643.329219,-45.053594],[-633.836250,-28.833750],[-623.730156,-12.987031],[-613.130000,2.420000],[-600.017656,20.202812],[-586.298750,37.507500],[-571.925469,54.268438],[-556.850000,70.420000],[-547.800000,80.250000],[-537.114375,89.716094],[-525.562500,98.911250],[-501.840000,115.750000],[-479.450332,129.625664],[-455.821406,142.040937],[-431.182090,152.569492],[-418.555056,156.993022],[-405.761250,160.785000],[-392.829280,163.892134],[-379.787754,166.261133],[-366.665281,167.838706],[-353.490469,168.571562],[-340.291926,168.406411],[-327.098262,167.289961],[-313.938083,165.168921],[-300.840000,161.990000],[-286.895781,157.404219],[-273.391250,151.748750],[-260.361094,145.071406],[-247.840000,137.420000],[-233.948125,127.287500],[-219.745000,115.242500],[-206.411875,102.286250],[-195.130000,89.420000],[-187.927129,79.332539],[-180.885156,67.705938],[-174.107793,54.965117],[-167.698750,41.535000],[-156.400469,14.306563],[-147.820000,-10.580000],[-141.899351,-31.653450],[-137.075898,-52.750410],[-133.323013,-73.860173],[-130.614063,-94.972031],[-128.922417,-116.075276],[-128.221445,-137.159199],[-128.484517,-158.213093],[-129.685000,-179.226250],[-131.796265,-200.187961],[-134.791680,-221.087520],[-138.644614,-241.914216],[-143.328438,-262.657344],[-148.816519,-283.306194],[-155.082227,-303.850059],[-162.098931,-324.278230],[-169.840000,-344.580000],[-192.590000,-394.580000],[-200.620000,-411.580000],[-207.818438,-424.276250],[-216.110000,-436.987500],[-225.069063,-449.245000],[-234.270000,-460.580000],[-249.188574,-476.868008],[-265.131719,-492.146563],[-282.001816,-506.414961],[-299.701250,-519.672500],[-318.132402,-531.918477],[-337.197656,-543.152188],[-356.799395,-553.372930],[-376.840000,-562.580000],[-372.461406,-569.012500],[-365.481250,-577.110000],[-352.120000,-591.580000],[-291.560000,-658.580000],[-271.560000,-680.580000],[-267.217500,-685.145000],[-264.576563,-687.048750],[-261.840000,-687.880000],[-258.625781,-687.084844],[-254.306250,-685.111250],[-246.840000,-681.000000],[-212.840000,-659.860000],[-188.704687,-641.748750],[-165.842500,-622.092500],[-144.296563,-601.000000],[-124.110000,-578.580000],[-93.840000,-538.580000],[-94.814219,-559.930605],[-97.593125,-582.091094],[-101.961094,-604.695723],[-107.702500,-627.378750],[-114.601719,-649.774434],[-122.443125,-671.517031],[-131.011094,-692.240801],[-140.090000,-711.580000]]);
  }
}

module rebelAllianceThumbnail(height = 1)
{
    xyScale = .044;
    scale([xyScale, xyScale, 1])
    rebelAlliance(height);
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