
/**
 * 
 * @param 
 * @param valign valid values are "top", "center", "baseline" and "bottom". Default is "baseline".
 * @return 
 */
module textExtrude(text, valign = "", font)  
{
    linear_extrude(height=4)
    text(text, font = font, size=6, valign = valign);
}