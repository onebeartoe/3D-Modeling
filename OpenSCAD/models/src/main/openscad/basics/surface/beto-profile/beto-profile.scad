
//cylinder (h = 4, r=10.9, center = true, $fn=100);

infile = "OpenSCAD_surface_example_input_image.png";

infile = "profile-a.png";

// Example 3b
scale([1, 1, 0.1])
surface(file = infile, 
        center = true, 
        invert = false);
