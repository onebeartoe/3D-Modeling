
use <../../half-circle-phone-stand.scad>

//difference()
{
    import("/home/roberto/Versioning/world/betoland/electronics/phone-stand/half-circle/3D_Lover/files/Part1.STL",
           convexity=10);

    xTranslate = 7.65;
    yTranslate = 6;
    translate([xTranslate, yTranslate, 0])
    halfCirclePhoneStand();
}
