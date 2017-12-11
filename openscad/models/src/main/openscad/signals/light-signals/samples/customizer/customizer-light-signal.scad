

// preview[view:south, tilt:bottom]
/**
	preview[view:south east, tilt:bottom diagonal] - meh
	preview[view:south, tilt:bottom diagonal]      - okay
	preview[view:south east, tilt:bottom diagonal] - nope
**/
use <../../light-signal.scad>

icon1 = ""; // [arrow, bat, cat, clover, dialog-bubble, doge, heart, pacman, oshw, rebel, spur, star, star-trek, texas, thundercat, trooper]
icon1_scale = 1;
icon1_x = 0;
icon1_y = 0;

icon2 = "";
icon2_scale = 1;
icon2_x = 0;
icon2_y = 0;

text1 = "Surprise!";
text1_fontName = "Bauhaus 93"; // @StencilFontNamesReplacement@
text1_fontSize = 6.5;
text1_x = -17;
text1_y = -3;

text2 = "";
text2_fontName = "Bauhaus 93"; // @StencilFontNamesReplacement@
text2_fontSize = 7.5;
text2_x = -18;
text2_y = -3;

mountingPosts = "Yes"; // [Yes, No]

lightSignal(icon1 = icon1,
			icon1_scale = icon1_scale,
			icon1_x = icon1_x,
			icon1_y = icon1_y,
			icon2 = icon2,
			icon2_scale = icon2_scale,
			icon2_x = icon2_x,
			icon2_y = icon2_y,
			mountingPosts = mountingPosts,
            text1 = text1,
			text1_fontName = text1_fontName,
			text1_fontSize = text1_fontSize,
            text1_x = text1_x,
            text1_y = text1_y,
            text2 = text2,
			text2_fontName = text2_fontName,
			text2_fontSize = text2_fontSize,
            text2_x = text2_x,
            text2_y = text2_y);
