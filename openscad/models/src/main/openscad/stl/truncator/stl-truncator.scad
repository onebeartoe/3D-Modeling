


module truncateStl(stlPath,
                   xRotate,
                   yRotate,
                   zRotate,
                   xyzScale,
                   xTranslate,
                   yTranslate,
                   zTranslate)
{
    difference()
    {
        translate([xTranslate, yTranslate, zTranslate])
        scale([xyzScale, xyzScale, xyzScale])
        rotate([xRotate, yRotate, zRotate])
        import(stlPath);
//        import(stlPath, center=false, convexity = 20);
//        import(stlPath, center=true, convexity = 10);

        truncateStl_bottomCutout();
    }
}

module truncateStl_bottomCutout()
{
    xyLength = 500;

    zLength = 300;

    zTranslate = - (zLength / 2.0) ;

    translate([0, 0, zTranslate]) 
    cube([xyLength, xyLength, zLength], center = true);
}