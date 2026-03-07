/*
 * Heart Pattern Coaster
 * 
 * Inspired by: https://www.mikekasberg.com/blog/2023/03/22/3d-printing-with-openscad.html
 */

// --- Parameters ---
coaster_radius = 50;     // Radius of the bounding circle
coaster_height = 4;      // Total height of the coaster
base_thickness = 2;      // Thickness of the solid bottom layer
heart_size = 10;         // Scale of the individual hearts
heart_spacing = 4;       // Space between heart centers (relative to heart_size)
coaster_label = "Robert"; // Text label in the center
$fn = 64;                // Smoothness of circles

// --- Modules ---

// A simple heart shape made of a square and two circles
// Centered at (0,0)
module heart(s) {
    // A standard heart with height and width approx s
    scale(s / 15.6)
    translate([0, -7.8, 0])
    rotate([0, 0, 45])
    union() {
        square([10, 10]);
        translate([5, 10, 0]) circle(d=10);
        translate([10, 5, 0]) circle(d=10);
    }
}

// The main coaster module
module heart_coaster(radius, height, base, h_size, spacing, label = "Robert") {
    union() 
    {
        difference() 
        {
            // 1. The main circular body
            cylinder(h=height, r=radius);
            
            // 2. Subtract the heart pattern (only from the top part)
            translate([0, 0, base])
            linear_extrude(height - base + 1) // +1 for clean cut
            intersection() {
                // Constrain pattern to the circle (slightly inset for a rim)
                circle(r=radius - 2);
                
                // Create the staggered grid of hearts
                // offset_y is smaller than offset_x to create a dense pattern
                offset_x = h_size + spacing;
                offset_y = (h_size + spacing) * 0.866; // approx sqrt(3)/2 for dense packing
                
                grid_x = ceil(radius * 2 / offset_x) + 1;
                grid_y = ceil(radius * 2 / offset_y) + 1;
                
                for (y = [-grid_y : grid_y]) {
                    shift_x = (abs(y) % 2 == 1) ? offset_x / 2 : 0;
                    for (x = [-grid_x : grid_x]) {
                        translate([x * offset_x + shift_x, y * offset_y, 0])
                        heart(h_size);
                    }
                }
            }
//REMOVE            
//}
            // remove the label outline 
            translate([0, 0, base * 2.0 ])
            cube(size=[70, 21, height],
                 center=true);            
// ADD BACK
        }
        
        // 3. The text label in the center
        // We use a union to ensure the text is solid even if hearts were subtracted
        linear_extrude(height)
        text(label, size=radius/3, halign="center", valign="center", $fn=16);
    }
}

// --- Execution ---
heart_coaster(coaster_radius, coaster_height, base_thickness, heart_size, heart_spacing, coaster_label);
