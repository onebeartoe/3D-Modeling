// originally from:
//       http://stackoverflow.com/questions/39564136/how-to-determine-width-of-text-in-openscad

// Fit text into a randomly generated area

r = rands(10, 20, 2);
length = 3 * r[0];
w = r[1];

length = 20;
w = 10;

difference() 
{
    cube([length, w, 1]);
    
    color("white")
        translate([0, w / 2, 0.6])
//            linear_extrude(1)
            linear_extrude(1, convexity = 4)
                resize([length, 0, 0], auto = true)
                    text("This is a Test", valign = "center");
}