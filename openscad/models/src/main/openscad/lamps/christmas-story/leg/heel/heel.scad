
stl = "/home/roberto/Versioning/world/betoland/household/lamps/christmas-story-leg-lamp/jetpuf/files/leg-blender-remesh.stl";

difference()
{
    // %
    import(stl
            , convexity = 15
            );

    //top cutout
    top_xyLength = 50;

    top_xyTranslate = -top_xyLength / 2.0;

    color("red")
    translate([top_xyTranslate, top_xyTranslate, 13])
    cube(size=[top_xyLength, top_xyLength, 140]);

    // foot cutout
    foot_xLength = 30;
    foot_yLength = 35;

    foot_xTranslate = -foot_xLength / 2.0;
    foot_yTranslate = -25.7;

    color("green")
    translate([foot_xTranslate, foot_yTranslate, 0])
    cube(size=[foot_xLength, foot_yLength, 140]);
}