
headCutoutRadius = 19;

module headRemover()
{
    difference()
    {
        cubeLengthX = 95;        
        cube([cubeLengthX, 85, 70]);

        translate([40, 120, -3])
        rotate([90, 0, 0])
        cylinder(r=headCutoutRadius, 
                 h=129,
                 $fn=60);
    }
}

module headlessTroll(stlPath, cutHeight)
{
    trollY = 140;
    difference()
    {
        translate([0, trollY, 0])
        originalTroll(stlPath);

        color("green")
        translate([-17, 132, 58.5])
        headRemover();
        
        // remove the left overs    
        color("orange")
        translate([21, 172, 74])
        rotate([0,20,0])
        cube([15, 30, 5]);
    }
}

// Jesse Troll?
module originalTroll(stlPath)
{
    translate([-20,-40,0])
    import(stlPath, convexity=10);   // Convexity is used when OpenSCAD imports an
                                     // STL file, so that no blank spots appear in the preview.
                                     // RTFM: https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/STL_Import_and_Export
}

/**
 * unionDifference: true gets union, false gets difference 
 */
module trollHead(stlPath)
{
    difference()
    {
        intersection()
        {
            translate([0, 260, 0])
            originalTroll(stlPath);

            translate([22.5, 295, 133.7])
            sphere(r=70.4);
        }

        translate([23, 272, 54])
        sphere(r=20);
        
        translate([23, 310, 54])
        sphere(r=20);

        color("green")
        translate([23, 280, 48])
        cube([20,25,20]);
        
        color("blue")
        
        translate([23, 277, 51.5])
        rotate([-9, 0, 0])                
        cube([20,25,20]);        
    }
}

module twoHeadedTroll(stlPath)
{
    union()
    {
        s = 0.7;
        headScale = [s, s, s];
        headRotate = 9.8;
        
        headX = 10;
        rightHeadY = 285;
        headZ = 22;
        
        // left head
        color("yellow")
        translate([headX, rightHeadY + 40, headZ+30])
        scale(headScale)
        rotate([-headRotate,-10,0])
        trollHead(stlPath);

        // right head
        color("red")
        translate([headX, rightHeadY+20, headZ-33])
        scale(headScale)
        rotate([headRotate, -0, 0])
        trollHead(stlPath);
        
        twoHeadedTranslateY = 340;
        
        // font neck part
        neckY = twoHeadedTranslateY + 183.5;
        neckRadius = headCutoutRadius - 2.3;
        translate([23.9, neckY - 9.5, 63.7])
        rotate([90,0,0])
        sphere(r=neckRadius,
               $fn=100);
        
        // back left neck part
        color("blue")
        translate([15, neckY - 5, 67.5])
        rotate([90,0,0])
        sphere(r=8,
               $fn=100);

        // back right neck part
        color("green")
        translate([16, neckY - 17, 67.5])
        rotate([90,0,0])
        sphere(r=9,
               $fn=100);        

        // body
        twoHeadedTranslate = [0, twoHeadedTranslateY, 0];
        color("pink")
        translate(twoHeadedTranslate)
        headlessTroll(stlPath);
    }    
}
