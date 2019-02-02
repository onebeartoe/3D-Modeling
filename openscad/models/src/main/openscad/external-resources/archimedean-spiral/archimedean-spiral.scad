
// spirals   = how many spirals
// thickness = how thick you want the arms to be
// rmax      = maximum radius
module archimedean_spiral(spirals=1, thickness=1, rmax = 100){
s = spirals*360;
t = thickness;
a = sqrt(pow(rmax,2)/(pow(s,2)*(pow(cos(s),2) + pow(sin(s),2))));
points=[
	for(i = [0:$fa:s]) [
		(i*a)*cos(i),
		(i*a)*sin(i)
	]
];
points_inner=[
	for(i = [s:-$fa:0]) [
		(((i*a)+t)*cos(i)),
		(((i*a)+t)*sin(i))
	]
];
polygon(concat(points,points_inner));
} 
