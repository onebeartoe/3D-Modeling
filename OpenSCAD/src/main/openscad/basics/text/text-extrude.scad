
oldFont = "Liberation Sans:style=Bold Italic";
font = "Bauhaus 93:style=Regular";
text = "OpenSCAD Rules!";

textExtrude(text);

module textExtrude(text)  
{
    linear_extrude(height=4)
    text(text, font = font, size=6);
}