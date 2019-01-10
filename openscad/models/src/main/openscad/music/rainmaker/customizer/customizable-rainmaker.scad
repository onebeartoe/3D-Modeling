
use <../../../connectors/end-cap/endcap.scad>

use <../rainmaker.scad>

/* [Shell] */

height = 380; // [140 : 380]

innerRadius = 20; // [30 : 40]

outerRadius = 24; // [34 : 46]

shellDecoration = "none"; // [none, bumps]

/* [Rungs] */

rungsPerLevel = 2; // [1 : 4]

stepRadius = 1; // [1 : 5]

zDistanceBetweenRungs = 5; // [1:150]

zRotateAngle = 25; // [5 : 180]

/* [Endcap] */

generateEndcap = true; // [false:true]

/* [Hidden] */

i = 3; // [1:100]

rainmaker(height = height,
          outerRadius = outerRadius,
          innerRadius = innerRadius,
		  rungsPerLevel = rungsPerLevel,
		  shellDecoration = shellDecoration,
	  	  stepRadius = stepRadius,
	  	  zDistanceBetweenRungs = zDistanceBetweenRungs,
	  	  zRotateAngle = zRotateAngle);

if(generateEndcap)
{
	xTranslate = outerRadius * 2 + 10;

	endcapHeight = 6;

	endcapOuterRadius = outerRadius + 4;

	translate([xTranslate, 0, 0])
	endcap(height = endcapHeight,
			innerRadius = outerRadius,
			outerRadius = endcapOuterRadius);

}
