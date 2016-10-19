difference () {
  cylinder(r=20, center=true, h=5);
  linear_extrude(height=50, center=true, convexity = 10, twist = 0) {
      polygon(points=[[0,0],[100,60],[100,-60]], paths=[[0,1,2]]);
  }
}
