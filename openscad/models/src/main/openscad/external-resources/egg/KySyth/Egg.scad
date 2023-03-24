
// OpenScad Eggs By Kevin Symss
//               updated by Roberto Marquez


kysythEgg();

// Main
module kysythEgg(Egg_Top    = 28,
                Egg_Radius = 15    , 
                Egg_Wall   =  1.45, 

                fn        = 60   ,

                Printable  = 0,
                excludeTop = false)
{
    $fn = fn; 

    if (Printable  == 0)
    {  
        rotate([0,180,0])  
        {
            Egg_Bottom(Egg_Radius=Egg_Radius,  Egg_Wall=Egg_Wall);
        }
    }

    if (Printable  == 1)  
    {
        translate([0,40,0])
        {
            Egg_Bottom(Egg_Radius=Egg_Radius,  Egg_Wall=Egg_Wall);
        }
    } 
        
    if(excludeTop)
    {
        echo("the top is excluded");
    }
    else
    {
        Egg_Top(Egg_Radius=Egg_Radius,  Egg_Top=Egg_Top,  Egg_Wall=Egg_Wall);
    }
}


module Egg_Top(Egg_Radius, Egg_Top, Egg_Wall) {
 difference()
 {
    resize(newsize=[Egg_Radius*2,Egg_Radius*2,Egg_Top])
    Half_Sphere(X=0, Egg_Radius = Egg_Radius);

 resize(newsize=[Egg_Radius*2-Egg_Wall*2,Egg_Radius*2-Egg_Wall*2,Egg_Top-Egg_Wall])
 translate([0,0,-0.1])Half_Sphere(X=Egg_Wall, Egg_Radius = Egg_Radius);}}
//

module Egg_Bottom(Egg_Radius, Egg_Wall){
 difference(){Half_Sphere(X=0, Egg_Radius=Egg_Radius);
 translate([0,0,-0.1])Half_Sphere(X=Egg_Wall, Egg_Radius=Egg_Radius);}}
//


module Half_Sphere(X,
                    Egg_Radius)
    rotate([0,180,0])
{
    Egg_radius=Egg_Radius-X;     

    difference()
    {
        sphere(r=Egg_radius);   
 
        translate([0,0,Egg_Radius])
        cube(size=Egg_Radius*2 ,center=true);
    }
}
//
