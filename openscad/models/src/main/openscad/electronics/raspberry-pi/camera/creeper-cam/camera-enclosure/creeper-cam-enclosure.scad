
use <../../../../../external-resources/electronics/single-board-computers/raspberry-pi/zero/camera/encosure/T_Hambush/camcase.scad>

module raspberryPiCreeperCamCase()
{
    difference()
    {
        translate([0,0,-14.4886])
        camcase_stl2scad();

        cutoutTransateZ = 7.5;
        cutoutLengthZ = 3;

        eyeSide = 7;

        nostriLengthX = 9;

        rightEyeTranslateX = 4.69;
        rightEyeTranslateY = -15.8;

        // right eye
        raspberryPiCreeperCamCase_rightEye(cutoutLengthZ,
                                           cutoutTransateZ,
                                           eyeSide,
                                           rightEyeTranslateX,
                                           rightEyeTranslateY);

        // right nostril
        raspberryPiCreeperCamCase_rightNostril(cutoutLengthZ,
                                               cutoutTransateZ,
                                               rightEyeTranslateX,
                                               rightEyeTranslateY,
                                               nostriLengthX);

        // left eye
        raspberryPiCreeperCamCase_rightEye(cutoutLengthZ,
                                         cutoutTransateZ,
                                         eyeSide,
                                         -rightEyeTranslateX * 2 - 2,
                                         rightEyeTranslateY);

       // right side mouth part
       translate([13.7, 4, 0])
       rotate([0,0,-90])
      raspberryPiCreeperCamCase_sideMouthPart(cutoutLengthZ,
                                             cutoutTransateZ,
                                              rightEyeTranslateX,
                                             rightEyeTranslateY,
                                              nostriLengthX - 2);



        // right side mouth part
        translate([1, 4, 0])
        rotate([0,0,-90])
       raspberryPiCreeperCamCase_sideMouthPart(cutoutLengthZ,
                                              cutoutTransateZ,
                                               rightEyeTranslateX,
                                              rightEyeTranslateY,
                                               nostriLengthX - 2);
    }
}

/** Support functions and methods follow **/

module raspberryPiCreeperCamCase_rightEye(cutoutLengthZ, cutoutTransateZ, eyeSide, rightEyeTranslateX, rightEyeTranslateY)
{
    color("black")
    translate([rightEyeTranslateX, rightEyeTranslateY, cutoutTransateZ])
    cube([eyeSide, eyeSide, cutoutLengthZ]);
}

module raspberryPiCreeperCamCase_rightNostril(cutoutLengthZ,
                                              cutoutTransateZ,
                                              rightEyeTranslateX,
                                              rightEyeTranslateY,
                                              nostrilSide)
{
    xTranslate = -nostrilSide / 2.0;
    yLength = nostrilSide / 4.0;
    yTranslate = -8.69;
    color("black")
    translate([xTranslate, yTranslate, cutoutTransateZ])
    cube([nostrilSide, yLength, cutoutLengthZ]);
}

module raspberryPiCreeperCamCase_sideMouthPart(cutoutLengthZ,
                                              cutoutTransateZ,
                                              rightEyeTranslateX,
                                              rightEyeTranslateY,
                                              nostrilSide)
{
    xTranslate = -0;//nostrilSide / 2.0;
    yLength = 3.5;
    yTranslate = -9;
    color("black")
    translate([xTranslate, yTranslate, cutoutTransateZ])
    cube([nostrilSide, yLength, cutoutLengthZ]);
}
