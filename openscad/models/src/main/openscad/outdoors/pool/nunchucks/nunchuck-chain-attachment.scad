// OpenSCAD script for Pool Nunchuck Chain Attachment

module nunChuckChainAttachment(
    outer_diameter = 30,
    plug_diameter = 25,
    plug_length = 20,
    cap_height = 10,
    eyelet_outer_radius = 8,
    eyelet_inner_radius = 4,
    wall_thickness = 3,
    screw_hole_diameter = 3.5,
    $fn = 60
) {
    difference() {
        union() {
            // Plug portion (fits into nunchuck handle core)
            cylinder(d = plug_diameter, h = plug_length);

            // Cap rim collar
            translate([0, 0, plug_length])
                cylinder(d = outer_diameter, h = cap_height);

            // Top eyelet loop for chain or rope attachment
            translate([0, 0, plug_length + cap_height])
                rotate([90, 0, 0])
                    cylinder(r = eyelet_outer_radius, h = wall_thickness * 2, center = true);
        }

        // Cross-screw hole to secure attachment to handle
        translate([0, 0, plug_length / 2])
            rotate([0, 90, 0])
                cylinder(d = screw_hole_diameter, h = outer_diameter + 10, center = true);

        // Chain loop hole
        translate([0, 0, plug_length + cap_height])
            rotate([90, 0, 0])
                cylinder(r = eyelet_inner_radius, h = wall_thickness * 2 + 2, center = true);
    }
}

