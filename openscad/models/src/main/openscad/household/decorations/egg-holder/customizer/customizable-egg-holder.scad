
use <../egg-holder.scad>

legHeight = 11; // [4:20]

toeHeight = 3.0; // [0.5 : 0.5 : 25]

zTranslate_toe = -16; // [-25 : 1 : 25]

/* [Hidden] */

if(false)
{
    rotate([0,0,90])
    translate([-50, 0, 0])
    import("/home/roberto/Versioning/world/beto-land-world/household/decorations/egg-holder/Works-Of-Claye/files/Egg_Holder.stl", convexity=3);
}

eggHolder(legHeight = legHeight,
            toeHeight = toeHeight,
            zTranslate_toe = zTranslate_toe);


