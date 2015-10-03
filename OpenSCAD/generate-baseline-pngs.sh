
# This script is meant to be run when the project is first started and there are many .oscad files without corresponding baseline .png files

# call this commnad with the following
# ./find-oscad-files.sh | ./generate-baseline-pngs.sh

# Import the global variables.
source ./global-variables.sh

# next is a path to the executable for OpenSCAD and an example call
# openscad -o ring.png ring.scad
openScad="/cygdrive/c/opt/OpenSCAD/openscad-2015.03-1/openscad"

while read line
do

	# remove the '.oscad' from the file name
	baseName=${line::-5}
	
	# concatinate '.png' to the base name
	outfileName=$baseName""$baselineSuffix

	if   [ ! -f $outfileName ] # test to see if the base comparison file exists
	then
	
		generateBaseLineCommand=$openScad" -o "$outfileName" "$line
		
		echo $generateBaseLineCommand
		
	fi

done < "${1:-/dev/stdin}"