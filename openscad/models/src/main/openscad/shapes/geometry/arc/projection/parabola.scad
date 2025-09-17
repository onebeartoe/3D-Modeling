
// This was inspired by the post found here:
//	http://forum.openscad.org/Parabolic-tube-tp28894p28897.html

module parabolaProjection(d1=20, h = 30)
{
//    projection(cut=false)
    projection(cut=true)
        rotate([0, 70, 0])
            cylinder(d1=d1, d2=0, h = h);
}

module parabola(d1=20, zExtrude = 50, h = 30)
{
//    linear_extrude(zExtrude)
    difference()
    {
        linear_extrude(zExtrude)
        parabolaProjection(d1=d1, h = h);

        translate([-0.9, 0, -1.0])
        linear_extrude(zExtrude + 2)
        parabolaProjection(d1=d1, h = h);

    //           parabolaProjection();
    }
}