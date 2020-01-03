
radius = 2.5;


//stl = "/home/roberto/Versioning/world/betoland/household/lamps/christmas-story-leg-lamp/jetpuf/files/leg-blender-remesh-solidify.stl";
stl = "/home/roberto/Versioning/world/betoland/household/lamps/christmas-story-leg-lamp/jetpuf/files/leg-blender-remesh.stl";
//stl = "/home/roberto/Versioning/world/betoland/household/lamps/christmas-story-leg-lamp/jetpuf/files/leg-blender-solidify.stl";
//stl = "/home/roberto/Versioning/world/betoland/household/lamps/christmas-story-leg-lamp/jetpuf/files/leg-blender-demimate.stl";
//stl = "/home/roberto/Versioning/world/betoland/household/lamps/christmas-story-leg-lamp/jetpuf/files/LegLamp_Leg.stl";


difference()
{
    // %
    import(stl
            , convexity = 35
            );

    // top cutout
    color("green")
    translate([1, -2, 124])
    cylinder(r = radius, h=8);

    // foot cutout
    color("green")
    translate([0, -8, -0.01])
    cylinder(r = radius, h=4);
}


// 2019.01.30.nightly (git f914a57) 

// 2019.12.26 


