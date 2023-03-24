// OpenScad Eggs By Kevin Symss

Egg_Top    = 28    ; // mm 
Egg_Radius = 15    ; // mm 
Egg_Wall   =  1.45 ; // mm 

$fn        = 60   ;

Printable  = 0   ;// 0 = Display or 1 = Printable

kysythEgg();

// Main
module kysythEgg()
{
    if (Printable  == 0)  
        rotate([0,180,0])  
        {
            Egg_Bottom();
        }

    if (Printable  == 1)  
        translate([0,40,0])
        {
            Egg_Bottom();
        } 
        Egg_Top();
}
//
     
// End

module Egg_Top() {
 difference(){resize(newsize=[Egg_Radius*2,Egg_Radius*2,Egg_Top])Half_Sphere(0);
 resize(newsize=[Egg_Radius*2-Egg_Wall*2,Egg_Radius*2-Egg_Wall*2,Egg_Top-Egg_Wall])
 translate([0,0,-0.1])Half_Sphere(Egg_Wall);}}
//

module Egg_Bottom(){
 difference(){Half_Sphere(0);
 translate([0,0,-0.1])Half_Sphere(Egg_Wall);}}
//

module Half_Sphere(X)rotate([0,180,0]){
 Egg_radius=Egg_Radius-X;     
 difference(){sphere(Egg_radius,true);   
 translate([0,0,Egg_Radius])cube(size=Egg_Radius*2 ,center=true);}}
//