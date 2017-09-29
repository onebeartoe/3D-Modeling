
use <attribution.text>

use <../basics/rounded-edges/rounded-cube/rounded-cube.scad>
use <../basics/text/text-extrude/text-extrude.scad>
use <../external-resources/music/notes/treble-clef/treble-clef-scaled-down.scad>
use <../external-resources/aquaman/aquaman-logo.scad>
use <../external-resources/plumber-brother/l/luigi-outline.scad>
use <../external-resources/plumber-brother/m/mario.scad>
use <../external-resources/rebel-alliance/rebel-alliance.scad>
use <../external-resources/thundercats/thundercats-logo.scad>
use <../mounting-hardware/chain-loop/rounded/rounded-chain-loop.scad>
use <../mounting-hardware/chain-loop/square/chain-loop.scad>
use <../shapes/crescent-moon/crescent-moon.scad>
use <../shapes/fan/iso-7000-fan.scad>
use <../shapes/light-bulb/light-bulb.scad>
use <../shapes/minecraft/creeper/creeper-face.scad>
use <../shapes/spurs/spurs-a.scad>
use <../shapes/weather/sun/sun.scad>

/* [Hidden] */

resolution=50; 	// Use 20 for draft, 100 for nice

borderWidth = 2;//5;

holediameter=3;
countersink=2;
holes = 0;//0;//2;//4; 			// Choose 0,2 or 4 (others=0)

fudge = 0.1;

// *************  Nametag Modules *************

module nametag(baseColor = "black",
               baseHeight = 54,
               baseThickness = 2,
               baseWidth = 200,
               borderColor = "yellow",
               borderHeight = 6,
               bottomText = "Love Lots",
               bottomTextFont = "Arial",
               bottomTextOffsetX = 0,
               bottomTextOffsetY = 0,
               bottomTextSize = 9,
               chainLoop = true,
			   chaneLoopCutoutAxis = "x",
               chainLoopLengthPercentageY = 0.75,
               chainLoopLengthPercentageZ = 0.65,
               chainLoopLengthZ = 10,
               chainLoopPosition = "bottom",
			   chainLoopType = "square",
               iconColor = "white",
               leftIconHeight = 1.5,
               leftIconType = "Light Bulb",
               leftIconXyScale = 1.0,
               letterThickness = 3,
               rightIconHeight = 1.5,
               rightIconOffsetY = 0,
               rightIconType = "Light Bulb",
               rightIconXyScale = 1.7,
               roundedCorners = true,
               showBorder = "No",
               topText = "Love is the Answer",
               topTextColor = "white",
               topTextFont = "Helvetica",
               topTextSize = 5,
               topTextOffsetY = 0,
               xIconOffset = 87,
               yIconOffset = 87)
{
    union()
    {
        nametag_assembly(baseColor = baseColor,
				baseHeight = baseHeight,
                baseThickness = baseThickness,
				baseWidth = baseWidth,
                borderColor = borderColor,
                borderdistance = 5,
                borderHeight = borderHeight,
                borderradius = 8,
				bottomText = bottomText,
                bottomTextFont = bottomTextFont,
                bottomTextOffsetX = bottomTextOffsetX,
                bottomTextOffsetY = bottomTextOffsetY,
                bottomTextSize = bottomTextSize,
				chainLoop = chainLoop,
				chaneLoopCutoutAxis = chaneLoopCutoutAxis,
                chainLoopLengthPercentageY = chainLoopLengthPercentageY,
                chainLoopLengthPercentageZ = chainLoopLengthPercentageZ,
                chainLoopLengthZ = chainLoopLengthZ,
                chainLoopPosition = chainLoopPosition,
				chainLoopType = chainLoopType,
                letterThickness = letterThickness,
				roundedCorners = roundedCorners,
				showBorder = showBorder,
                topText = topText,
                topTextColor = topTextColor,
                topTextFont = topTextFont,
                topTextOffsetY = topTextOffsetY,
				textSize = topTextSize);

        icons(iconColor = iconColor,
              leftIconType = leftIconType,
              leftIconXyScale = leftIconXyScale,
              leftIconHeight = leftIconHeight,
              rightIconType = rightIconType,
              rightIconHeight = rightIconHeight,
              rightIconXyScale = rightIconXyScale,
              xOffset = xIconOffset,
              yOffset = yIconOffset,
              yRightOffset = rightIconOffsetY);
    }
}

module nametag_assembly(baseColor,
						baseHeight,
                        baseThickness,
						baseWidth,
                        borderColor,
						borderdistance,
                        borderHeight,
						borderradius,
						bottomText,
                        bottomTextFont,
                        bottomTextOffsetX,
                        bottomTextOffsetY,
                        bottomTextSize,
						chainLoop,
						chaneLoopCutoutAxis,
                        chainLoopLengthPercentageY,
                        chainLoopLengthPercentageZ,
                        chainLoopLengthZ,
                        chainLoopPosition,
						chainLoopType,
                        letterThickness,
						roundedCorners,
						showBorder,
                        topText,
                        topTextColor,
                        topTextFont,
                        textSize,
                        topTextOffsetY)
{
    // top text
    color(topTextColor)
    translate([0, topTextOffsetY, 0])
    textExtrude(text=topText,
                textSize = textSize,
                font = topTextFont,
                height = 5);

    // bottom text
    translate([bottomTextOffsetX, bottomTextOffsetY,0])
    textExtrude(text = bottomText,
                textSize=bottomTextSize,
                font = bottomTextFont,
                height = 5);

    if(showBorder == "Yes")
    {
        color(borderColor)
                                // Having the assignments in the method call caused an issue.
                                // So the assigments are left out.
        nametagBorder(baseHeight,
					  baseThickness,
                      baseWidth,
					  borderdistance,
                      borderHeight,
					  borderradius,
                      letterThickness,
                      roundedCorners);
    }

    if (holes==2)
    {
            base2holes(baseColor, baseWidth, baseHeight, borderdistance, roundedCorners);
    }
    else
    {
        if (holes==4)
        {
            base4holes(baseColor, baseWidth, baseHeight,
					   chainLoop,
					   chainLoopPosition,
					   chainLoopType,
					   borderdistance, roundedCorners);
        }
        else
        {
            nametagBase(baseColor,
                        baseHeight,
						baseThickness,
                        baseWidth,
                        chainLoop,
						chaneLoopCutoutAxis,
                        chainLoopLengthPercentageY,
                        chainLoopLengthPercentageZ,
                        chainLoopLengthZ,
                        chainLoopPosition,
						chainLoopType,
                        roundedCorners);
        }
    }
}

module oneIcon(iconColor, iconType, iconXyScale, iconHeight, xOffset, yOffset)
{
    color(iconColor)
    translate([xOffset, yOffset, 0])
    scale([iconXyScale, iconXyScale, iconHeight])
    if(iconType == "Aqua Dude")
    {
        aquamanThumbnail(height=1.6);
//        aquaman(4);
    }
    else if(iconType == "Bass Clef")
    {
    	baseclef15scale(1.8);
//    	baseclef15scale(4);
    }
    else if(iconType == "Cat")
    {
        cat(1.8);
    }
    else if(iconType == "Creeper")
    {
        creeperFaceThumbnail(height = 1.7);
    }
    else if(iconType == "Fan")
    {
        scale([1, 1, 1.6])
        fanThumbnail();
    }
    else if(iconType == "Light Bulb")
    {
        lightBulbThumbnail();
    }
    else if(iconType == "Mario")
    {
        marioThumbnail();
    }
    else if(iconType == "Luigi")
    {
        luigiThumbnail();
    }
    else if(iconType == "Moon")
    {
        crescentMoonThumbnail();
    }
    else if(iconType == "Rebel")
    {
        rebelAllianceThumbnail(height = 1.7);
    }
    else if(iconType == "Spur")
    {
        spurThumbnail();
    }
    else if(iconType == "Sun")
    {
        sunThumbnail(height = 1.6);
    }
    else if(iconType == "Trooper")
    {
        scrumtrooper(2);
    }
    else if(iconType == "Thundercat")
    {
        thundercatsLogoThumbnail(height = 1.7);
    }
    else if(iconType == "Treble Clef")
    {
        trebleClefScaledDownThumbnail(h=2);
    }
    else
    {
//        echo("drawing no icons");
    }
}

module base2holes(baseColor,
                  baseThickness,
                  baseWidth,
                  baseHeight,
                  chainLoop,
				  chaneLoopCutoutAxis,
                  chainLoopLengthPercentageY,
                  chainLoopLengthPercentageZ,
                  chainLoopLengthZ,
                  chainLoopPosition,
				  chainLoopType,
                  borderdistance,
                  roundedCorners)
{
	difference()
	{
		nametagBase(baseColor,
					baseHeight,
                    baseThickness,
                    baseWidth,
					borderdistance,
                            chainLoop,
							chaneLoopCutoutAxis,
                            chainLoopLengthPercentageY,
                            chainLoopLengthPercentageZ,
                            chainLoopLengthZ,
                            chainLoopPosition,
							chainLoopType,
                            roundedCorners);

		translate([-(baseWidth/2-borderdistance*2-borderWidth-countersink-holediameter),0,0])
			nametagHole(baseThickness);
		translate([(baseWidth/2-borderdistance*2-borderWidth-countersink-holediameter),(0),0])
			nametagHole(baseThickness);
	}
}

//TODO: whitespace format this module
module base4holes(baseColor,
					baseHeight,
					baseThickness,
					baseWidth,
					borderdistance,
                  chainLoop,
				  chaneLoopCutoutAxis,
                  chainLoopLengthPercentageY,
                  chainLoopLengthPercentageZ,
                  chainLoopLengthZ,
                  chainLoopPosition,
				  chainLoopType,
                  roundedCorners)
{
	difference()
	{
		nametagBase(baseColor,
					baseHeight,
                    baseThickness,
                    baseWidth,
					borderdistance,
                            chainLoop,
							chaneLoopCutoutAxis,
                            chainLoopLengthPercentageY,
                            chainLoopLengthPercentageZ,
                            chainLoopLengthZ,
                            chainLoopPosition,
							chainLoopType,
                            roundedCorners);

		translate([(baseWidth/2-borderdistance),(baseHeight/2-borderdistance),0])
                nametagHole(baseThickness);

		translate([(baseWidth/2-borderdistance),-(baseHeight/2-borderdistance),0])
                nametagHole(baseThickness);

		translate([-(baseWidth/2-borderdistance),(baseHeight/2-borderdistance),0])
                nametagHole(baseThickness);

		translate([-(baseWidth/2-borderdistance),-(baseHeight/2-borderdistance),0])
                nametagHole(baseThickness);
	}
}

module icons(iconColor,
             leftIconType,
             leftIconXyScale,
             rightIconXyScale,
             leftIconHeight,
             rightIconHeight,
             xOffset,
             yOffset,
             xRightOffset,
             yRightOffset)
{
    // left icon
    oneIcon(iconColor = iconColor, iconType=leftIconType,  iconXyScale=leftIconXyScale, iconHeight=leftIconHeight, xOffset=-xOffset, yOffset=yOffset);

    // right icon
    oneIcon(iconColor = iconColor, iconType=rightIconType, iconXyScale=rightIconXyScale, iconHeight=rightIconHeight, xOffset=xOffset, yOffset=yRightOffset);
}

module nametagBase(baseColor,
                   baseHeight,
				   baseThickness,
                   baseWidth,
                   chainLoop,
				   chaneLoopCutoutAxis,
                   chainLoopLengthPercentageY,
                   chainLoopLengthPercentageZ,
                   chainLoopLengthZ,
                   chainLoopPosition,
				   chainLoopType,
                   roundedCorners)
{
    size = [baseWidth, baseHeight, baseThickness];

	cornerRadius = 8;

    color(baseColor)
    translate([0,0,baseThickness/2])
    if(roundedCorners)
    {
        roundedCube(size=size,
                    cornerRadius = cornerRadius,
                    sides=30,
                    sidesOnly=true,
                    cubeCentered=true);
    }
    else
    {
        cube(size = size, center = true);
    }

    if(chainLoop)
    {
    		if(chainLoopType == "square")
    		{
			       x = 21;
	           y = 8;

	           xTranslate = -x / 2.0;

	//TODO: fix the 4 to be relative to the 8 of the rounded corner radius
	        yBottomDelta = (-baseHeight / 2.0) - (y + 4);
	        yTopDelta = (baseHeight / 2.0) + (y / 2.0);

	//        yTranslate = (chainLoopPosition == "top") ? yTopDelta : - yTopDelta;
	        yTranslate = (chainLoopPosition == "bottom") ? yBottomDelta : yTopDelta;

	        translate([xTranslate, yTranslate, 0])
	        chainLoop(cutoutAxis = chaneLoopCutoutAxis,
					          xLength = x,
	                  yLength = y,
	                  yPercentage = chainLoopLengthPercentageY,
	                  zLength = chainLoopLengthZ,
	                  zPercentage = chainLoopLengthPercentageZ);
        }
  		  else if(chainLoopType == "rounded")
  		  {
      			outerRadius = 10;

      			xTranslate = 0;
      			yTranslate = //outerRadius * 2
                         //			 			 baseHeight - outerRadius - cornerRadius
       			 			       (outerRadius) + (cornerRadius / 2.0) + (baseHeight / 2.0);

      			translate([xTranslate, yTranslate, 0])
      			roundedChainLoop(height = 5,
      							         outerRadius = outerRadius);
		    }
    }
}

module nametagBorder(baseHeight,
					 baseThickness,
                     baseWidth,
					 borderdistance,
					 borderHeight,
                     borderradius,
                     letterThickness,
                     roundedCorners)
{
	color("pink")
    translate([0,0,baseThickness/2])
// this next commented line was causing the 'floating' border issue
//    translate([0,0,baseThickness+letterThickness/2])
    linear_extrude(height = borderHeight, center = false, convexity = 10, twist = 0)
    {
        translate([0,baseHeight/2-borderdistance,0])
            square ([baseWidth-borderdistance*2-borderradius*2+borderWidth*2,borderWidth],center = true);

        translate([0,-(baseHeight/2-borderdistance),0])
            square ([baseWidth-borderdistance*2-borderradius*2+borderWidth*2,borderWidth],center = true);

        translate([baseWidth/2-borderdistance,0,0])
            square ([borderWidth, baseHeight-borderdistance*2-borderradius*2+borderWidth*2,],center = true);

        translate([-(baseWidth/2-borderdistance),0,0])
            square ([borderWidth, baseHeight-borderdistance*2-borderradius*2+borderWidth*2,],center = true);

        translate([-(baseWidth/2-borderdistance),-(baseHeight/2-borderdistance),0])
            rotate(a=[0,0,0])
                nametagQuarter(baseWidth, borderradius);

        translate([(baseWidth/2-borderdistance),(baseHeight/2-borderdistance),0])
            rotate(a=[0,0,180])
                nametagQuarter(baseWidth, borderradius);

        translate([(baseWidth/2-borderdistance),-(baseHeight/2-borderdistance),0])
            rotate(a=[0,0,90])
                nametagQuarter(baseWidth, borderradius);

        translate([-(baseWidth/2-borderdistance),(baseHeight/2-borderdistance),0])
            rotate(a=[0,0,270])
                nametagQuarter(baseWidth, borderradius);
    }
}

module nametagQuarter(baseWidth, borderradius)
{
	intersection()
	{
		difference()
		{
			circle(r = borderradius, center=true, $fn=resolution);
			circle(r = borderradius-borderWidth, center=true, $fn=resolution);
		}
		square ([borderradius+1, borderradius+1],center = false);
	}
}

module nametagHole(baseThickness)
{
	translate([0,0,baseThickness/2])
		cylinder(h = baseThickness+0.1, r = holediameter/2, $fn=resolution, center = true);
	translate([0,0,baseThickness-countersink])
		cylinder(h = countersink+0.1, r1 = holediameter/2, r2 = (holediameter+2*countersink)/2, $fn=resolution, center = false);
}

// *************  External Modules *************

//TODO: Replace this with: onebeartoe/github\3D-Modeling\OpenSCAD\library\src\main\openscad\external-resources\music\notes\bass-clef\bass-clef.scad
module baseclef15scale(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-53.879273,-55.635750],[-49.678523,-57.651750],[-45.266273,-59.060250],[-43.916273,-59.142750],[-42.116273,-59.387250],[-40.016273,-59.141250],[-38.816273,-59.060250],[-35.041594,-58.017938],[-31.373086,-56.193750],[-28.132922,-53.712563],[-25.643273,-50.699250],[-23.732648,-46.578375],[-22.746773,-42.149250],[-22.466273,-40.499250],[-22.169273,-36.599250],[-22.466273,-33.149250],[-22.734773,-31.499250],[-23.921461,-26.847000],[-26.063273,-22.541250],[-27.860599,-20.221860],[-29.935219,-18.298102],[-32.245351,-16.744714],[-34.749211,-15.536438],[-37.405017,-14.648013],[-40.170984,-14.054180],[-45.866273,-13.649250],[-49.038211,-13.977750],[-52.166273,-14.634750],[-56.627273,-16.542000],[-60.566273,-19.362750],[-62.965898,-22.170938],[-64.845773,-25.349250],[-66.906773,-29.849250],[-67.938398,-33.444234],[-68.623523,-37.107000],[-69.116273,-44.549250],[-68.672273,-49.349250],[-68.672273,-50.399250],[-68.394773,-51.449250],[-67.468758,-55.755070],[-66.147023,-59.731688],[-64.396664,-63.542086],[-62.184773,-67.349250],[-58.863773,-71.924250],[-54.917273,-75.872250],[-53.729273,-76.800750],[-48.884273,-80.480250],[-45.116273,-82.575750],[-39.767836,-85.007250],[-34.166273,-86.754750],[-31.766273,-87.393750],[-30.116273,-87.710250],[-29.066273,-87.797250],[-28.016273,-88.056750],[-26.816273,-88.056750],[-25.466273,-88.343250],[-23.966273,-88.343250],[-22.466273,-88.499250],[-13.016273,-88.335750],[-11.216273,-88.046250],[-10.016273,-88.046250],[-8.966273,-87.755250],[-7.916273,-87.755250],[-6.866273,-87.488250],[-5.966273,-87.410250],[-3.416273,-86.756250],[-0.116273,-85.992750],[6.681914,-83.633625],[10.069266,-82.097156],[13.085227,-80.412750],[18.385805,-76.472977],[23.161852,-71.784937],[27.323086,-66.532430],[30.779227,-60.899250],[33.239414,-55.528312],[35.214727,-49.949250],[36.116227,-46.949250],[36.863227,-43.349250],[37.176727,-42.299250],[37.265227,-41.249250],[37.527727,-40.199250],[37.527727,-38.849250],[37.726852,-38.037000],[37.833727,-36.599250],[38.133727,-34.049250],[38.433727,-29.099250],[38.433727,-19.499250],[38.133727,-15.749250],[38.041477,-14.423437],[37.832227,-13.499250],[37.832227,-11.999250],[37.530727,-10.949250],[37.530727,-9.899250],[37.272727,-8.999250],[37.178227,-8.099250],[36.572227,-5.549250],[35.817727,-2.099250],[33.915727,4.050750],[29.984977,13.970438],[24.983227,23.400750],[22.493227,27.150750],[18.755109,32.327648],[14.807039,37.119937],[10.576312,41.667258],[5.990227,46.109250],[4.559227,47.337750],[-3.378047,54.038203],[-11.767711,60.166875],[-20.534531,65.750484],[-29.603273,70.815750],[-36.591773,74.433750],[-40.316273,76.064250],[-49.079273,80.001750],[-51.224273,80.804250],[-62.966273,85.167750],[-70.016273,87.557250],[-71.610023,88.156500],[-73.316273,88.499250],[-74.524008,88.363430],[-75.811898,87.900938],[-76.572727,87.096727],[-76.565736,86.561774],[-76.199273,85.935750],[-75.521273,85.313250],[-73.657898,84.321188],[-71.666273,83.478750],[-66.416273,81.095250],[-56.216273,76.634250],[-48.836273,72.926250],[-43.329773,69.981750],[-37.767773,66.417750],[-34.466273,64.344750],[-29.340773,60.600750],[-23.730773,56.244750],[-22.458773,55.052250],[-17.222273,50.349750],[-15.168773,48.156750],[-11.691773,44.550750],[-9.078773,41.399250],[-5.213273,36.587250],[-2.285273,32.250750],[0.912727,27.150750],[3.285656,22.670156],[5.544539,17.708625],[7.527516,12.630656],[9.072727,7.800750],[10.830727,0.300750],[10.830727,-0.599250],[11.133727,-1.649250],[11.133727,-2.699250],[11.408227,-3.749250],[11.610727,-5.549250],[11.883727,-7.799250],[12.197227,-10.649250],[12.197227,-12.449250],[12.483727,-14.699250],[12.483727,-27.449250],[12.195727,-29.699250],[12.195727,-32.099250],[11.879227,-33.899250],[11.879227,-35.249250],[11.181727,-39.449250],[11.094727,-40.649250],[10.836727,-41.549250],[10.836727,-42.599250],[10.589227,-43.499250],[10.478227,-44.399250],[9.839227,-47.249250],[9.428227,-49.649250],[7.781227,-55.949250],[5.837227,-60.749250],[5.028727,-62.562750],[3.038812,-66.165844],[0.767789,-69.456750],[-1.859016,-72.464156],[-4.916273,-75.216750],[-8.188523,-77.533687],[-11.816273,-79.221750],[-13.466273,-79.842750],[-18.716273,-80.999250],[-20.366273,-80.999250],[-22.016273,-81.285750],[-24.266273,-81.285750],[-26.366273,-81.024750],[-28.316273,-80.930250],[-29.816273,-80.576250],[-33.188273,-79.936125],[-36.416273,-78.951750],[-41.974711,-76.728187],[-47.066273,-73.578750],[-49.952086,-71.410875],[-52.593773,-68.952750],[-53.447273,-67.862250],[-55.706086,-64.713000],[-57.329273,-61.199250],[-58.463273,-57.599250],[-58.463273,-56.699250],[-58.677773,-55.902562],[-58.766273,-54.749250],[-58.766273,-53.699250],[-58.616273,-52.199250],[-53.879273,-55.635750]]);
    linear_extrude(height=h)
      polygon([[66.483727,-72.005250],[68.183789,-71.796375],[69.797227,-71.220750],[72.819727,-69.378844],[74.975977,-66.879375],[76.236727,-63.820219],[76.572727,-60.299250],[76.046039,-57.155813],[74.663227,-54.281250],[73.105477,-52.499016],[71.092102,-51.025875],[68.819414,-50.022422],[66.483727,-49.649250],[63.633727,-49.649250],[61.985227,-49.936125],[60.422227,-50.544750],[57.933727,-51.977250],[56.394117,-53.517938],[55.157977,-55.426500],[54.334711,-57.540938],[54.033727,-59.699250],[54.033727,-62.099250],[54.380414,-64.165313],[55.097227,-66.149250],[56.467852,-68.241023],[58.316602,-69.921188],[60.502289,-71.158383],[62.883727,-71.921250],[64.533727,-72.086250],[66.483727,-72.005250]]);
    linear_extrude(height=h)
      polygon([[66.333727,-20.099250],[67.796414,-19.941750],[69.183727,-19.445250],[71.702930,-18.132797],[73.788727,-16.340250],[75.343523,-14.088703],[76.269727,-11.399250],[76.533727,-9.899250],[76.432664,-6.941438],[75.666727,-4.074750],[74.536453,-2.163844],[72.945914,-0.429000],[71.057531,0.971719],[69.033727,1.880250],[66.633727,2.276250],[65.133727,2.394750],[62.733727,2.211750],[59.699039,1.090500],[57.077227,-0.813750],[55.890188,-2.251781],[54.926039,-3.959250],[54.276609,-5.802844],[54.033727,-7.649250],[54.033727,-10.049250],[54.311344,-12.041531],[55.031789,-13.997250],[56.097328,-15.797719],[57.410227,-17.324250],[59.976539,-19.003875],[62.883727,-20.010750],[66.333727,-20.099250]]);
  }
}

module scrumtrooper_poly_Selection(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-33.094424,-44.902344],[-25.219053,-51.135742],[-16.283955,-55.413281],[-6.691904,-57.734727],[3.154326,-58.099844],[12.851963,-56.508398],[21.998232,-52.960156],[30.190361,-47.454883],[33.802756,-43.968286],[37.025576,-39.992344],[40.318232,-33.900469],[42.396826,-27.062344],[43.487295,-19.939219],[43.815576,-12.992344],[16.815576,-20.552344],[0.885889,-21.888125],[-14.321924,-20.821094],[-29.210986,-17.479687],[-44.184424,-11.992344],[-43.358643,-21.146563],[-41.830674,-29.628594],[-38.707080,-37.520000],[-36.267725,-41.269707],[-33.094424,-44.902344]]);
    linear_extrude(height=h)
      polygon([[20.815576,1.937656],[26.856826,4.863906],[31.825576,7.707656],[33.005947,10.129336],[33.292295,12.911719],[32.819971,15.867070],[31.724326,18.807656],[28.204482,23.893594],[26.050986,25.663477],[23.815576,26.667656],[21.526357,26.542969],[19.391826,25.355156],[15.815576,22.017656],[8.953076,15.842656],[4.950889,13.324219],[0.815576,12.157656],[-3.940049,12.919531],[-8.414424,15.305156],[-12.453799,18.587031],[-15.904424,22.037656],[-19.470674,25.787656],[-21.637705,26.959531],[-24.184424,26.837656],[-26.283604,25.711230],[-28.302861,23.918125],[-31.631924,18.983906],[-33.232236,13.339062],[-33.090557,10.657676],[-32.164424,8.287656],[-30.441924,6.566250],[-28.126924,5.458906],[-22.184424,2.877656],[-17.192236,-0.728125],[-13.071924,-4.518594],[-9.007861,-8.145938],[-4.184424,-11.262344],[0.224365,-11.826777],[3.853389,-11.335938],[6.909131,-10.001113],[9.598076,-8.033594],[14.701514,-3.045625],[20.815576,1.937656]]);
    difference()
    {
       linear_extrude(height=h)
         polygon([[-52.144424,33.007656],[-52.736143,30.722500],[-52.565674,28.496406],[-51.404424,24.007656],[-49.066924,16.367656],[-47.044424,11.007656],[-45.736924,1.875156],[-44.136299,-1.848281],[-42.534893,-3.493555],[-40.184424,-4.992344],[-37.836924,-0.649844],[-36.947236,1.749219],[-36.704424,4.007656],[-37.693018,6.902031],[-39.513174,9.507656],[-41.323955,12.113281],[-42.284424,15.007656],[-41.150518,19.141719],[-38.050674,24.012656],[-31.094424,31.817656],[-27.954424,34.111406],[-26.180986,34.620312],[-24.184424,34.417656],[-21.906201,33.335020],[-19.520518,31.569063],[-14.300674,26.958906],[-8.272705,22.530625],[-4.876865,20.992012],[-1.184424,20.227656],[4.007451,20.756719],[8.648076,22.802656],[12.872451,25.793594],[16.815576,29.157656],[20.948076,32.712656],[23.360264,34.135781],[25.815576,34.617656],[28.609639,33.526875],[31.660576,31.163906],[36.605576,26.007656],[39.459326,22.172656],[41.705576,18.007656],[42.146260,15.846992],[41.961045,13.993594],[40.344326,10.900156],[38.118232,8.110469],[36.545576,5.007656],[36.600889,2.622500],[37.475576,-0.048594],[39.815576,-4.992344],[42.963076,-3.616094],[45.075576,-0.882344],[47.075576,12.007656],[51.106826,22.205156],[52.628857,27.723906],[52.736143,30.363516],[52.205576,32.837656],[50.927139,34.908281],[48.983076,36.915156],[44.905576,40.437656],[40.598076,44.997656],[36.815576,50.007656],[37.815576,51.007656],[47.815576,43.007656],[41.753076,51.403906],[37.898701,55.201250],[33.815576,57.497656],[28.674014,58.062031],[23.643076,57.137656],[13.815576,53.927656],[2.815576,52.177656],[-6.266924,52.541406],[-15.184424,54.367656],[-25.053174,57.572656],[-30.134268,58.099844],[-35.184424,56.847656],[-38.693486,54.471562],[-41.904424,51.196406],[-47.184424,44.007656],[-37.184424,50.007656],[-42.448330,43.177656],[-46.723174,38.950156],[-49.968643,36.001406],[-52.144424,33.007656]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-46.184424,24.007656],[-39.184424,34.007656],[-34.184424,33.007656],[-36.198643,29.399219],[-38.838174,26.370156],[-42.150830,24.409844],[-46.184424,24.007656]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[33.815576,33.007656],[38.815576,34.007656],[46.815576,24.007656],[42.582139,24.176406],[39.033076,26.152656],[36.125264,29.306406],[33.815576,33.007656]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[31.595576,51.217656],[33.840889,49.183906],[34.460576,46.062656],[34.007881,44.499687],[32.965264,43.151406],[31.271553,42.180000],[28.865576,41.747656],[26.638838,43.402676],[25.479795,45.194687],[25.221455,46.987871],[25.696826,48.646406],[28.180732,51.016250],[29.855283,51.455918],[31.595576,51.217656]]);
    }
    linear_extrude(height=h)
      polygon([[-47.184424,43.007656],[-50.184424,40.007656],[-47.184424,43.007656]]);
  }
}

module scrumtrooper(h)
{
    scrumtrooper_poly_Selection(h);
}

module cat(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-89.303594,-104.629248],[-85.166094,-99.396748],[-82.764531,-97.935498],[-79.093594,-97.689248],[-73.093594,-98.369248],[-68.013594,-97.617998],[-65.480156,-97.394717],[-63.263594,-97.819248],[-59.814844,-100.871748],[-56.793594,-104.629248],[-50.784844,-111.007998],[-44.093594,-116.629248],[-42.441094,-105.601748],[-42.093594,-93.629248],[-43.143594,-78.629248],[-42.223594,-62.629248],[-41.788750,-58.176279],[-40.267344,-55.385498],[-34.553594,-49.619248],[-28.923594,-43.099248],[-25.092051,-40.151104],[-20.623125,-37.536592],[-10.392344,-32.887998],[0.530312,-28.312529],[10.906406,-22.969248],[19.912305,-16.495576],[27.339219,-9.343623],[33.410977,-1.556982],[38.351406,6.820752],[42.384336,15.745986],[45.733594,25.175127],[51.276406,45.370752],[54.823906,61.462002],[55.672344,69.984346],[54.906406,77.320752],[62.417656,78.348252],[66.107187,78.198252],[69.906406,77.320752],[74.808086,74.786826],[78.637969,71.183096],[81.452070,66.746631],[83.306406,61.714502],[84.256992,56.323779],[84.359844,50.811533],[83.670977,45.414834],[82.246406,40.370752],[78.707656,33.798096],[73.751406,27.209502],[68.622656,20.701533],[64.566406,14.370752],[62.782500,10.057783],[61.627656,5.599502],[60.916406,-3.629248],[61.565508,-10.284189],[63.193594,-17.100029],[65.771836,-23.759541],[69.271406,-29.945498],[73.663477,-35.340674],[78.919219,-39.627842],[85.009805,-42.489775],[91.906406,-43.609248],[95.427656,-43.562998],[98.866406,-43.059248],[101.152480,-42.035400],[102.940625,-40.559092],[105.022656,-36.640498],[105.111563,-32.086279],[103.206406,-27.679248],[100.696758,-25.168994],[97.396094,-23.109092],[89.716406,-19.370498],[85.984727,-17.206885],[82.756719,-14.523779],[80.356055,-11.078721],[79.106406,-6.629248],[79.120020,-3.430732],[79.783437,-0.235498],[82.520156,6.038252],[89.856406,17.370752],[93.929844,24.436221],[97.071406,31.662002],[99.117969,39.242158],[99.906406,47.370752],[99.805156,57.912002],[97.986406,68.370752],[95.456406,75.547002],[92.146406,82.370752],[86.956406,89.436846],[80.573906,95.369502],[73.167656,99.927783],[64.906406,102.870752],[55.353906,104.250752],[48.906406,104.580752],[39.906406,107.040752],[21.906406,108.660752],[12.209687,110.591064],[1.587656,113.288252],[-8.875000,115.576689],[-18.093594,116.280752],[-23.837813,115.457314],[-27.447344,113.983252],[-34.093594,109.930752],[-47.093594,105.370752],[-48.464844,109.924502],[-49.598125,111.902783],[-51.313594,113.720752],[-54.457051,115.659678],[-58.360000,116.977158],[-62.707559,117.629248],[-67.184844,117.572002],[-71.476973,116.761475],[-75.269063,115.153721],[-78.246230,112.704795],[-80.093594,109.370752],[-84.093594,109.370752],[-87.971406,109.297002],[-92.286094,108.683252],[-95.869531,106.918252],[-97.021992,105.413018],[-97.553594,103.390752],[-97.271699,101.220811],[-96.198438,99.561221],[-92.517344,97.129502],[-88.189375,94.808408],[-86.307520,93.287100],[-84.893594,91.310752],[-82.320781,83.058877],[-79.828594,70.723252],[-78.011406,58.196377],[-77.463594,49.370752],[-78.103906,42.263564],[-79.346094,35.533252],[-81.274531,28.971689],[-83.973594,22.370752],[-91.236094,8.637002],[-94.669531,1.674971],[-97.313594,-5.629248],[-98.282188,-10.995029],[-98.814844,-17.467998],[-99.093594,-29.629248],[-100.036719,-39.220029],[-102.093594,-48.275498],[-104.150469,-57.257842],[-105.093594,-66.629248],[-104.814844,-73.019092],[-104.183594,-77.382998],[-103.183594,-83.629248],[-103.848750,-89.460654],[-104.912344,-96.492998],[-105.111563,-105.593467],[-103.183594,-117.629248],[-95.853594,-111.579248],[-89.303594,-104.629248]]);
  }
}
