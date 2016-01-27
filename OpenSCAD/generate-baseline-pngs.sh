
# This meant to be run when the project is first started and there are 
# any/many .oscad files without corresponding baseline .png files

# call this commnad with the following
# ./find-oscad-files.sh | ./generate-baseline-pngs.sh

# Import the global variables.
source ./global-variables.sh

./find-oscad-files.sh | ./generate-pngs.sh
