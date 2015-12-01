# Read all lines from standard input (or file named as the 1st argument).

# assumne no problems will occur and set the exit code to 0; success
exitCode=0

while read line
do

	# remove the '.oscad' from the file name
	baseName=${line::-5}
	
	# concatinate '.png' to the base name
	baselineInfile=$baseName""$baselineSuffix
	
	proposedBaselineInfile=$baseName""$proposedBaselineSuffix

	
#	generateBaseLineCommand="diff "$baselineInfile" "$proposedBaselineInfile

		
	# compare the PNG files
	diff $baselineInfile  $proposedBaselineInfile
	
	# check the exit code
	if   [ "$?" -ne 0 ] # test to see if the base comparison file exists
	then
		# There was an issue with the diff comparison; set the exit code to failure.
		exitCode=111
	fi

done < "${1:-/dev/stdin}"

exit $exitCode