
/**
 * 
 * @param 
 * @param valign valid values are "top", "center", "baseline" and "bottom". Default is "baseline".
 * @return 
 */
module textExtrude(text, textSize=6, valign = "center", font, height=4)
{
    linear_extrude(height=height)
    text(text, 
         font = font, 
         size=textSize, 
         valign = valign,
         halign = "center");
}