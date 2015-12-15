
crucifixionCcross();

module crucifixionCcross(height=2)
{
    beamWidth = 3;
    
    union()
    {
        // vertical beam
        xTranslate = -beamWidth / 2.0;
        yLength = 13;
        color("brown")
        translate([xTranslate, 0, 0])
        cube([3, yLength, height]);

        // horizontal beam        
        yTranslate = yLength * 0.5;
        xLength = yLength * 0.75;
        xTranslateHBeam = -xLength / 2.0;
        
        echo("yt: ", yTranslate);
        echo("xl: ", xLength);
        echo("xt", xTranslateHBeam);
        
        color("green")
        translate([xTranslateHBeam, yTranslate, 0])
        cube([xLength, 3, height]);        
    }        
}
