
oldFont = "Liberation Sans:style=Bold Italic";
font = "Bauhaus 93:style=Regular";

textExtrude();

module textExtrude()  
{
	linear_extrude(height=4)
   	text("OpenSCAD Rules!", font = font, size=6);
}