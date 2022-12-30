

use <../../../external-resources/toys/fidget-spinners/nested-rings/switchborg/nested-rings.scad>

use <../chameleon-eyes/chameleon-glasses.scad>

use <../../../shapes/open-cylinder/open-cylinder.scad>

xTranslate = -(stockNestedRings_outerRadius() * 1 + 12.5);

module frame()
{
    color("green")
    openCylinder(height = height,
            outerRadius = outerRadius,
            innerRadius = innerRadius,
            fn = fn);
}


//showCameleonFrame = true;
showCameleonFrame = false;

if(showCameleonFrame)
{
    translate([xTranslate,0,0])
    chameleonGlasses();
}

fn = 60;
height = 5;
outerRadius = (-xTranslate * 2) - 5;
innerRadius = outerRadius - 5;

difference()
{
    frame();

    color("red")
    translate([0, 30, -0.001])
    cylinder(r=outerRadius, h =  height + 1);
}

translateArmX = 81;
translate([translateArmX,0,0])
cube([5,100,height]);



translateOtherArmX = -86;
color("purple")
translate([translateOtherArmX,0,0])
cube([5,100,height]);
