
use <../../sine-vase.scad>

heart_xRotate = 120; // [-180 : 1 : 180]

heart_yRotate = 50; // [-180 : 1 : 180]

heart_zRotate = 75; // [-180 : 1 : 180]

internalCutout_TopRadiusOffset = 22; // [0 : 1 : 30]

sineVase(internalCutout_bottomRadius = 36,
         internalCutout_TopRadiusOffset = internalCutout_TopRadiusOffset,
         vaseType = "heart"


,
heart_xRotate = heart_xRotate,
heart_yRotate = heart_yRotate,
heart_zRotate = heart_zRotate


     );
