
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
                               verticalPadding = 15,
                               zLength = 2)
{
    union()
    {
        cubeLengthX = horizontalPadding + 
                      slotWidth1 +
                      horizontalPadding;

        cubeLengthY = verticalPadding + 
                      STANDARD_LETTER_HEIGHT +
                      verticalPadding;                              

        color("green")
        cube(center = true,
             size = [cubeLengthX, cubeLengthY, zLength]);

        letter1TranslateX = horizontalPadding;
        letterSymbol(slot1, slotWidth1, letter1TranslateX);
    }
}

module letterSymbol(slot, slotWidth, letterTranslateX)
{
    if(slot == SYMBOL_LIGHTNING_BOLT)
    {
        lightningBolt(height = 10);
    }
    else
    {
        echo("no slot id found for: ", slot);
    }
}