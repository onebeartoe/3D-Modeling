
module headlessTroll(stlPath, cutHeight)
{
    difference()
    {
        translate([0, 140, 0])
        originalTroll(stlPath);
//	}		
        color("green")
        translate([-20, 120, 70])
        cube([90, 110, 60]);
//		sphere(r=45);
    }
}

// Jesse Troll?
module originalTroll(stlPath)
{
    translate([-20,-40,0])
    import(stlPath);
}

module originalTrollWithBase(stlPath)
{
	union()
	{
		originalTroll(stlPath);
		
		cube([50,50,2]);
	}
}

/**
 * unionDifference: true gets union, false gets difference 
 */
module trollHead(stlPath)
{
//    difference()
    intersection()
    {
//        color("orange")
        translate([0, 260, 0])
        originalTroll(stlPath);
        
//        color("blue")
        translate([21, 295, 131])
//        translate([3, 295, 0])
        sphere(r=69);
//        sphere(r=69);
//        cube([40, 40,5]);
    }	
}

module twoHeadedTroll(stlPath)
{
    color("green")
    union()
    {
        // left head
        translate([0, 260, 0])
        rotate([0,-10,0])
        trollHead(stlPath);    

        // right head
        rotate([3,-10,0])
        translate([0, 195, 0])        
        trollHead(stlPath);    

        // body
        // two headed troll
        twoHeadedTranslate = [0,340,0];
        translate(twoHeadedTranslate)
        headlessTroll(stlPath);
    }    
}
