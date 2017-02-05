
oldFont = "Liberation Sans:style=Bold Italic";
font = "Bauhaus 93:style=Regular";
text = "OpenSCAD Rules!";

textExtrude(text);

/**
 * 
 * @param 
 * @param valign valid values are "top", "center", "baseline" and "bottom". Default is "baseline".
 * @return 
 */
module textExtrude(text, valign = "")  
{
    linear_extrude(height=4)
    text(text, font = font, size=6, valign = valign);
}