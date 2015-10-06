# This script generatges .png files from all .oscad files.
# It generates proposed baseline .png files by default.
# Set $baselineSuffix to create someting else.

# Next is a path to the executable for OpenSCAD and an example call.
# openscad -o ring.png ring.scad
openScad="/cygdrive/c/opt/OpenSCAD/openscad-2015.03-1/openscad"

# Read all lines from standard input (or file named as the 1st argument).
while read line
do

	# remove the '.oscad' from the file name
	baseName=${line::-5}
	
	# concatinate '.png' to the base name
	outfileName=$baseName""$baselineSuffix

	if   [ ! -f $outfileName ] || [ "$forcePngGeneration" == true ] # test to see if the proposed baseline PNG file exists OR if the PNG is to be generated regardless of the file existing or not (generate-proposed-pngs.sh )
	then
	
		generateBaseLineCommand=$openScad" -o "$outfileName" "$line

		echo $generateBaseLineCommand
		
		# run the command
		`$generateBaseLineCommand`
	fi

done < "${1:-/dev/stdin}"
