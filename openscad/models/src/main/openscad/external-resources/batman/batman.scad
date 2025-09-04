
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
module batmanLogoThumbnail(height = 1)
{
    xyScale = 0.27;
    translate([0.4, -0.3, 0])
    scale([xyScale, xyScale, 2.78])	
    batmanLogo(height = height);
}
