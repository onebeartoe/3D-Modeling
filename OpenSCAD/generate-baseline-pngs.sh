
# This meant to be run when the project is first started and there are many .oscad files without corresponding baseline .png files

# call this commnad with the following
# ./find-oscad-files.sh | ./generate-baseline-pngs.sh

# Import the global variables.
source ./global-variables.sh

export baselineSuffix="-proposed"$baselineSuffix

./generate-pngs.sh
