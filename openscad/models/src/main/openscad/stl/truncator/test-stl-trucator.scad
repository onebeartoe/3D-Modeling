
use <stl-truncator.scad>


stlPath = "/home/roberto/Versioning/world/betoland/star-wars/the-mandalorian/baby-yoda/smiling/DMag24/files/Baby_Yoda_Smile.stl";

xRotate = 90;    // [0 : 180]

yRotate = 0;

zRotate = 0;

xyzScale = 2.3622; // in Cura, this value was 236.22;

xTranslate = 0;

yTranslate = 0; 

zTranslate = -48;     // [-100 : 0.1 : 500]

truncateStl(stlPath = stlPath,
            xRotate = xRotate,
            yRotate = yRotate,
            zRotate = zRotate,
            xyzScale = xyzScale,
            xTranslate = xTranslate,
            yTranslate = yTranslate,
            zTranslate = zTranslate);
