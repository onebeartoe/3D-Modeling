
module cornerConnector(grooveThickness = 2,
                       outerCubeSize = 40,
                       wallThickness = 4)
{
    difference()
    {
        cube(outerCubeSize, outerCubeSize, outerCubeSize);

        // x cutout
color("blue")
        translate([wallThickness, wallThickness,wallThickness])
        cube([outerCubeSize, grooveThickness, outerCubeSize]);

        // y cutout
color("blue")
        translate([wallThickness, wallThickness,wallThickness])
        cube([grooveThickness, outerCubeSize, outerCubeSize]);

        // z cutout
// color("green")
//         translate([wallThickness, wallThickness,wallThickness])
//         cube([outerCubeSize, outerCubeSize, grooveThickness]);        

        // main cutout
        mainCutoutTranslateY = wallThickness + grooveThickness + wallThickness;
color("green")
        translate([mainCutoutTranslateY, mainCutoutTranslateY, wallThickness])
//        translate([wallThickness+grooveThickness*2, mainCutoutTranslateY, wallThickness])
        cube([outerCubeSize, outerCubeSize, outerCubeSize]);                
    }
}