
# Import the global variables.
#source ./global-variables.sh

export baselineSuffix="-proposed"$baselineSuffix

export forcePngGeneration=true

./generate-pngs.sh
