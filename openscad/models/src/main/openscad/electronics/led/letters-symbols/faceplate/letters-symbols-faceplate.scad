
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

                               verticalPadding = 15,
                               zLength = 2)
{
    union()
    {
        cubeLengthX = horizontalPadding + 
                      slotWidth1 +
                      horizontalPadding + 
                      slotWidth2 +
                      horizontalPadding;

        cubeLengthY = verticalPadding + 
                      STANDARD_LETTER_HEIGHT +
                      verticalPadding;                              

        color("green")
        cube(
//             center = true,
             size = [cubeLengthX, cubeLengthY, zLength]);

        letter1TranslateX = horizontalPadding + slotWidth1 / 2.0;
        letterSymbol(letterTranslateX=letter1TranslateX, 
                     slot=slot1, slotWidth=slotWidth1,
                     verticalPadding = verticalPadding);

        letter2TranslateX = letter1TranslateX + horizontalPadding + slotWidth2;
        letterSymbol(letterTranslateX=letter2TranslateX, 
                     slot=slot2, slotWidth=slotWidth2,
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
    else
    {
        echo("no slot id found for: ", slot);
        cube(center = true,
             size = [10, 10, 20]);
    }
}