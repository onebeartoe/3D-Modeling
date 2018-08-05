
use <../../../external-resources/toys/fidget-spinners/nested-rings/switchborg/nested-rings.scad>
use <../../../external-resources/toys/fidget-spinners/nested-rings/switchborg/parameterized/parameterized-nested-rings.scad>

use <../../../shapes/open-cylinder/open-cylinder.scad>

module chameleonGlasses(noseBridge_xLength = 25)
{
	union()
	{
	    stockNestedRings();

		outerRadius = stockNestedRings_outerRadius();

		step = stockNestedRings_step();

		ring_count = stockNestedRings_ringCount();

		xTranslate = outerRadius
					 + (stockNestedRings_biconeGap() + step) * ring_count
					 + noseBridge_xLength;

	    translate([xTranslate,0,0])
	    stockNestedRings();

		chameleonGlasses_noseBridge(noseBridge_xLength, outerRadius);

		tab1_translateX = - outerRadius
						  - chameleonGlasses_sewTab1_sideLength()
						  + step
						  + 0.32;
		tab1_translateY = - chameleonGlasses_sewTab1_sideLength() / 2.0;
		tab1_translateZ = - stockNestedRings_ringWidth() / 2.0;
		translate([tab1_translateX, tab1_translateY, tab1_translateZ])
		chameleonGlasses_sewTab1();

		tab2_translateX = -tab1_translateX * 2
						  - tab1_translateX
						  + chameleonGlasses_sewTab1_sideLength()
						  + 1.89;
		tab2_translateY = chameleonGlasses_sewTab1_sideLength() / 2.0;
		translate([tab2_translateX, tab2_translateY, tab1_translateZ])
		rotate([0,0,180])
		chameleonGlasses_sewTab1();
	}
}

module chameleonGlasses_noseBridge(noseBridge_xLength, lenseOuterRadius)
{
	height = 10;

	outerRadius = noseBridge_xLength / 2.0
				  + 4;

	rotation = [90,0,0];

	xTranslate = lenseOuterRadius + (noseBridge_xLength / 2.0);
	yTranslate = height / 2.0;
	zTranslate = -outerRadius / 2.0 -5;

	translation = [xTranslate, yTranslate, zTranslate];

	difference()
	{
		translate(translation)
		rotate(rotation)
		openCylinder(height = height,
					 innerRadius = outerRadius - 4,
					 outerRadius = outerRadius);

	    xLength = noseBridge_xLength + 16;
		yLength = 20;
		zLength = outerRadius + 20;
		cutout = [xLength, yLength, zLength];

		cutoutTranslationX =   (xLength / 2.0) + 5 ;
		cutoutTranslationY = -height;
		cutoutTranslationZ = - (stockNestedRings_ringWidth() / 2.0) - (zLength);
		cutoutTranslation = [cutoutTranslationX, cutoutTranslationY, cutoutTranslationZ];

		chameleonGlasses_noseBridgeCutout(cutout = cutout, translation = cutoutTranslation);
	}
}

module chameleonGlasses_noseBridgeCutout(cutout, translation)
{
	translate(translation)
	cube(cutout);
}

module chameleonGlasses_sewTab1()
{
	difference()
	{
		zLength = 2.6;
		sideLength = chameleonGlasses_sewTab1_sideLength();
		cube([sideLength, sideLength, zLength]);

		offsetX = sideLength - 8;
		offsetY = sideLength - 8;

		holeRadius = 1;

		translate([offsetX, offsetY, -0.1])
		cylinder(h = 10, r = holeRadius);

		xOffset2 = 3;
		yOffset2 = 8;
		translate([xOffset2, yOffset2, -0.1])
		cylinder(h = 10, r = holeRadius);
	}
}

function chameleonGlasses_sewTab1_sideLength() = 10;
