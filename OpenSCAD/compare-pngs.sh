# Read all lines from standard input (or file named as the 1st argument).
while read line
do

	# remove the '.oscad' from the file name
	baseName=${line::-5}
	
	# concatinate '.png' to the base name
	baselineInfile=$baseName""$baselineSuffix
	
	proposedBaselineInfile=$baseName""$proposedBaselineSuffix


	
		generateBaseLineCommand="diff "$baselineInfile" "$proposedBaselineInfile

#		echo $generateBaseLineCommand
		
		# run the command
#		`$generateBaseLineCommand`
		
		diff $baselineInfile  $proposedBaselineInfile

done < "${1:-/dev/stdin}"


