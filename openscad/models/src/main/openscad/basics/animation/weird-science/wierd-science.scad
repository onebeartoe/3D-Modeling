
scale = 1 + ($t * 1.1);

color("DodgerBlue")
translate([-14, -10, 80])
scale([scale, scale, scale])
grandTetons();

maniquinScale = 0.8;
color("DeepSkyBlue")
translate([0, 0, -10])
scale([maniquinScale, maniquinScale, maniquinScale])
import("/home/roberto/Distribute/world/maniquin/Body.stl");

module grandTetons()
{
    rotate([90, 0, 0])
    union()
    {
        grandTetons_oneTeton();

        translate([30, 0, 0])
        grandTetons_oneTeton();
    }
}

module grandTetons_oneTeton()
{
    import("/home/roberto/Distribute/world/sculptures/jellyfish-lamp/files/head_full_voro_simplified.stl");
}

// animation settings:
//    FPS: 20
//    Steps: 100
