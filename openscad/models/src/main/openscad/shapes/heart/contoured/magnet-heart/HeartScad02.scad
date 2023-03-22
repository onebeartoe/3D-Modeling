
//
// This source code is origianlly from this Cults item:
//      
//      https://www.printables.com/model/123882-better-heart-parametric-openscad-love-symbol/files
//

$fn=77;
depth=40;
botDia=3;
sphereBottom=true;
raise=45;
upLobe=50;
outLobe=.5;
smidge=.1;
//
//oneHeart();
module oneHeart()
{
    union()
    {
        //rotate([0,15,0])
        oneLobe();
        rotate([0,0,180])oneLobe();
    }
}
module oneCLHeart()
{
    union()
    {
        rotate([0,15,0])oneOldLobe();
        rotate([0,-15,0])oneOldLobe();
        centerLobe();
    }
}
//oneLobe();
module oneLobe()
{
    hull()
    {
        translate([-depth*outLobe,0,upLobe])scale([1.2,1,1.3])sphere(d=depth);
        centerSurface();
    }
}
//centerSurface();
module centerSurface()
{
    rotate([0,0,0])hull()
    {
        translate([0,0,raise])scale([1.5,1,1])rotate([0,90,0])cylinder(d=depth,h=smidge,center=true);
        //translate([0,0,0])
     if(sphereBottom) scale([1,1.5,1])sphere(d=botDia);
      else scale([1,1.5,1])rotate([0,90,0])cylinder(d=botDia,h=smidge,center=true);
    }
}
module oneOldHeart()
{
    union()
    {
        rotate([0,15,0])oneOldLobe();
        rotate([0,-15,0])oneOldLobe();
    }
}
module oneOldLobe()
{
    hull()
    {
        translate([0,0,60])scale([1,1.1,1.1])sphere(r=30);
        translate([0,0,0])scale([1,1.5,1])sphere(r=3);
    }
}
