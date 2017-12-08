

// preview[view:south, tilt:bottom]
/**
	preview[view:south east, tilt:bottom diagonal] - meh
	preview[view:south, tilt:bottom diagonal]      - okay
	preview[view:south east, tilt:bottom diagonal] - nope
**/
use <../../light-signal.scad>

icon1 = ""; // [arrow, bat, cat, clover, dialog-bubble, heart, rebel, spur, star]

text1 = "";
text1_fontName = "Bauhaus 93"; // @StencilFontNamesReplacement@
text1_x = -18;
text1_y = -3;

mountingPosts = "Yes"; // [Yes, No]

lightSignal(icon1 = "star",
			mountingPosts = mountingPosts,
            text1 = text1,
			text1_fontName = text1_fontName,
            text1_x = text1_x,
            text1_y = text1_y);
