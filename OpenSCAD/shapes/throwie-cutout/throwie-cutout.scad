
throwieCutout();

/**
 * this modeled after a 5mm LED
 */
module throwieCutout(height=2)
{
    ledWidth = 10;
    ledHeight = 13;
    
    union()
    {
        // LED bottom cutout
        ledBottomCutoutLengthX = ledWidth + 1 + 1; 
        xTranslate = -ledBottomCutoutLengthX / 2.0;
        yLength = 13;
        color("brown")
        translate([xTranslate, 0, 0])
        cube([ledBottomCutoutLengthX, 2, height]);

        // LED middle coutout        
        yTranslate = 2;
        xLength = ledWidth + 1;
        xTranslateHBeam = -xLength / 2.0; 
        color("green")
        translate([xTranslateHBeam, yTranslate, 0])
        cube([xLength, 7, height]);
        
        // LED curved top
        curvedTopTranslateY = (2 + 7);
        curvedTopRadius = (ledWidth / 2.0) + 0.5;
        color("red")
        translate([0, curvedTopTranslateY, 0])
        cylinder (h = height, r=curvedTopRadius, $fn=100);
        
        // battery
        batteryRadius = 10;
        translate([0, -15, 0])
        cylinder (h = height, r=batteryRadius, $fn=100);
    }        
}