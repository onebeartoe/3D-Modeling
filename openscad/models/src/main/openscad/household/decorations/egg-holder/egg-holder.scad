
use <../../../basics/rounded-edges/doughnuts/doughnuts.scad>

module eggHolder(legHeight = 12,
                 toeHeight = 3.0,
                 zTranslate_toe = -16)
{
    union()
    {
        holder();

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
        zRotate = 35;
        scale = 0.6;
        scale([scale,scale,scale])
        rotate([0, 0, zRotate])
        translate([9, 0, 0])
        chickenFoot_toe(height = toeHeight,
                        minkowskiSphereRadius = 0.5,
                        radius = 20,
                        zTranslate_toe = zTranslate_toe);

        // right toe
        scale([scale,scale,scale])
        rotate([0, 0, -zRotate])
        translate([9, 0, 0])
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

module holder()
{

}
