
// This was inspired by the post found here:
//	http://forum.openscad.org/Parabolic-tube-tp28894p28897.html

module parabola()
{
//    projection(cut=false)
    projection(cut=true)
        rotate([0, 70, 0])
            cylinder(d1=20, d2=0, h = 30);
}

    linear_extrude(50)
        difference()
    {
            parabola();
   
            translate([-1,0,0])
            parabola()
//            offset(-1)
                parabola();
    }        
