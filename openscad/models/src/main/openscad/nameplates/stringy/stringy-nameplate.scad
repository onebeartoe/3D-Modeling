
use <../../basics/text/text-extrude/text-extrude.scad>
use <../../toys/treasure-troll/hair/troll-hair.scad>

module stringyNameplate(hairLength = 50,
                        squareSide = 20,
                        step = 2.4,
                        text = "Pamfilo")
{
    union()
    {
        trollHair(hairLength = hairLength,
                  squareSide = squareSide,
                  step = step);

        height = 6;
        xTranslate = (1 / 2.0) + (hairLength / 2.0);
        yTranslate = squareSide / 2.0;
        zTranslate  = (squareSide / 2.0) - (height / 2.0);
        translate([xTranslate, yTranslate, zTranslate])
        name(text = text,
             textSize = 8,
             font = "Arial",
             height = height);
    }
}

module name(text, textSize, font, height)
{
    textExtrude(text=text,
                textSize = textSize,
                font = font,
                height = height);
}