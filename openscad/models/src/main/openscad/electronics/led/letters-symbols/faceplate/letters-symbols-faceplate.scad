
use <../D.scad>;
use <../E.scad>;
use <../G.scad>;
use <../I.scad>;
use <../O.scad>;
use <../lightning-bolt.scad>;

LETTER_D = 68;
LETTER_E = 69;
LETTER_G = 71;
LETTER_I = 73;
LETTER_O = 79;

SYMBOL_LIGHTNING_BOLT = 33;

STANDARD_LETTER_HEIGHT = 33; // see the O.scad

module lettersSymbolsFaceplate(horizontalPadding = 10,

                               slot1 = SYMBOL_LIGHTNING_BOLT,
                               slotWidth1 = 20.6,

                               slot2 = LETTER_D,
                               slotWidth2 = 24.6,

                               slot3 = LETTER_I,
                               slotWidth3 = 3,

                               slot4 = LETTER_E,
                               slotWidth4 = 20.2,

                               slot5 = LETTER_G,
                               slotWidth5 = 24.1,

                               verticalPadding = 15,
                               zLength = 2)
{
//    difference()
    union()
    {
        cubeLengthX = horizontalPadding + 
                      slotWidth1 +
                      horizontalPadding + 
                      slotWidth2 +
                      horizontalPadding + 
                      slotWidth3 +
                      horizontalPadding + 
                      slotWidth4 +
                      horizontalPadding +
                      slotWidth5 +
                      horizontalPadding
                      + 50;

        cubeLengthY = verticalPadding + 
                      STANDARD_LETTER_HEIGHT +
                      verticalPadding;                              

        color("green")
        cube(
//             center = true,
             size = [cubeLengthX, cubeLengthY, zLength]);

        letter1TranslateX = horizontalPadding + slotWidth1 / 2.0;
        letterSymbol(letterTranslateX=letter1TranslateX, 
                     slot=slot1, 
                     slotWidth=slotWidth1,
                     verticalPadding = verticalPadding);

        letter2TranslateX = letter1TranslateX + horizontalPadding + slotWidth2 ;
        letterSymbol(letterTranslateX=letter2TranslateX, 
                     slot=slot2, 
                     slotWidth=slotWidth2,
                     verticalPadding = verticalPadding);

        letter3TranslateX = letter2TranslateX +  slotWidth2 / 2.0 + horizontalPadding + slotWidth3;
        letterSymbol(letterTranslateX=letter3TranslateX, 
                     slot=slot3, 
                     slotWidth=slotWidth3,
                     verticalPadding = verticalPadding);

        letter4TranslateX = letter3TranslateX 
                                    + horizontalPadding * 2
                                    + slotWidth3;
        letterSymbol(letterTranslateX=letter4TranslateX, 
                     slot=slot4, 
                     slotWidth=slotWidth4,
                     verticalPadding = verticalPadding);

        letter5TranslateX = letter4TranslateX
                                + horizontalPadding 
                                + slotWidth4;
        letterSymbol(letterTranslateX=letter5TranslateX, 
                     slot=slot5,
                     slotWidth=slotWidth5,
                     verticalPadding = verticalPadding);                     
    }
}



module letterSymbol(slot, slotWidth, letterTranslateX,
                    verticalPadding)
{
    letterLengthZ = 10;

echo("letterTranslateX: ", letterTranslateX);

    letterTranslateY = verticalPadding  + STANDARD_LETTER_HEIGHT / 2.0;

    translate([letterTranslateX, letterTranslateY, -2.01])
    if(slot == SYMBOL_LIGHTNING_BOLT)
    {
        lightningBolt(height = letterLengthZ);
    }
    else if(slot == LETTER_D)
    {
        D(h = letterLengthZ);
    }
    else if(slot == LETTER_E)
    {
        E(height = letterLengthZ);
    }
    else if(slot == LETTER_G)
    {
        G(height = letterLengthZ);
    }
    else if(slot == LETTER_I)
    {
        I(height = letterLengthZ);
    }
    else
    {
        echo("no slot id found for: ", slot);
        cube(center = true,
             size = [10, 10, 20]);
    }
}
