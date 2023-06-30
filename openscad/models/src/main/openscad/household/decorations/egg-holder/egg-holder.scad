
use <../../../basics/rounded-edges/doughnuts/doughnuts.scad>
use <../../../external-resources/egg/KySyth/Egg.scad>

module eggHolder(Egg_Radius = 19,
                 legHeight = 11,
                 toeHeight = 3.0,
                 zTranslate_toe = -16)
{
    union()
    {
        holder(Egg_Radius = Egg_Radius);


        chickenFeet(legHeight = legHeight,
                    toeHeight = toeHeight,
                    zTranslate_toe = zTranslate_toe);
    }
}

module chickenFeet(legHeight, 
                    toeHeight,
                    zTranslate_toe)
{
    zRotate = -20;
    yTranslate = -6;

    rotate([0, 0, zRotate])
    translate([0, yTranslate, 0])    
    chickenFoot(legHeight = legHeight,
                toeHeight = toeHeight,
                zTranslate_toe = zTranslate_toe);

    rotate([0, 0, -zRotate])
    translate([0, -yTranslate, 0])
    {
        chickenFoot(legHeight = legHeight,
                    toeHeight = toeHeight,
                    zTranslate_toe = zTranslate_toe);
    }
}

module chickenFoot(legHeight,
                    toeHeight,
                    zTranslate_toe)
{
    union()
    {
        // leg
        translate([2, 0, 0])
        cylinder(center=false,
                 $fn=19,
                 r=2, 
                 h=legHeight);

        // center toe
        translate([4, 0, 0])
        chickenFoot_toe(height = toeHeight,
                        minkowskiSphereRadius = 0.5,
                        radius = 20,
                        zTranslate_toe = zTranslate_toe);

        // left toe
        xTranslate = 9;
        zRotate = 35;
        scale = 0.6;
        scale([scale,scale,scale])
        rotate([0, 0, zRotate])
        translate([xTranslate, 0, 0])
        chickenFoot_toe(height = toeHeight,
                        minkowskiSphereRadius = 0.5,
                        radius = 20,
                        zTranslate_toe = zTranslate_toe);

        // right toe
        scale([scale,scale,scale])
        rotate([0, 0, -zRotate])
        translate([xTranslate, 0, 0])
        chickenFoot_toe(height = toeHeight,
                        minkowskiSphereRadius = 0.5,
                        radius = 20,
                        zTranslate_toe = zTranslate_toe);                                                
    }
}

module chickenFoot_toe(height,
                       minkowskiSphereRadius,
                       radius,
                       zTranslate_toe)
{
    difference()
    { 
        yTranslate_toe =  ( (height / 2.0) +  (minkowskiSphereRadius / 2.0) );
//        zTranslate_toe = -15;
        translate([0, yTranslate_toe, zTranslate_toe])
        rotate([90, 0, 0])
        roundedDisk(height = height,
                    minkowskiSphereRadius = minkowskiSphereRadius,
                    radius = radius);

        // cutout
        side = 60;
        yTranslate = -side / 2.0;
        translate([0, 0, yTranslate])
        cube([side, side, side],
             center = true);
    }
}

module connectors()
{
    $fn = 30;

    zTranslate = 10;

//    rotate([-30,0,0])
    translate([-0,-6, zTranslate])
    rotate([-90, 0, 0])    
    cylinder(r=1, h = 12);
}

module holder(Egg_Radius)
{
    zTranslate = -28;
union()
{
    connectors();

    difference()
    {
        // holder
        rotate([180, 0, 0])    
        translate([0, 0, zTranslate])
        kysythEgg(Printable  = 1,
                    Egg_Radius = Egg_Radius,
                    moveBottom = false,
                    excludeTop = true);

        // cutout
        translate([-20, -80, 17])
        cube(size=[50, 100, 20]);
        //, center=true);
    }
}    
}
