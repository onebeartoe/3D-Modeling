pupils=false;
rotate ([0, 0, 180]) 
difference () {
  union() {
    cylinder(r=20, center=true, h=5);
    translate([0, 10, 0]) {
       cube([40, 20, 5], center=true);
    }
  }

  translate([13, 20, 0]) {
    rotate([0, 0, 45]) {
       cube([10, 10, 10], center=true);
    }
  }

  translate([-13, 20, 0]) {
    rotate([0, 0, 45]) {
       cube([10, 10, 10], center=true);
    }
  }

  translate([0, 20, 0]) {
    rotate([0, 0, 45]) {
       cube([10, 10, 10], center=true);
    }
  }

  translate([-8, -3, 0]) {
     cylinder(r=4, center=true, h=10);
  }

  translate([8, -3, 0]) {
     cylinder(r=4, center=true, h=10);
  }

}

if (pupils) {
  translate([-9, -1, 0]) {
     cylinder(r=3, center=true, h=5);
  }

  translate([7, -1, 0]) {
     cylinder(r=3, center=true, h=5);
  }
}
