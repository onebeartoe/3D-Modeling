
cd ../../external-resources/bezier/

ll

echo "farto"

java -jar /opt/onebeartoe/test-suite-0.0.1-SNAPSHOT-jar-with-dependencies.jar 

if [ $? -eq 0 ] 
then 
  echo "JustinSDK passed" 
else 
  echo "JustinSDK  failed!!!!!!!!"

  play ../../../../../../../../software-development-tools/filesystem/watcher/command-line/demos/word-count/whomp.mp3
fi

pwd

cd ../../vases/bezier/

java -jar /opt/onebeartoe/test-suite-0.0.1-SNAPSHOT-jar-with-dependencies.jar 

if [ $? -eq 0 ] 
then 
  echo "onebartoe passed" 
else 
  echo "onebeartoe  failed!!!!!!!!"

  play ../../../../../../../../software-development-tools/filesystem/watcher/command-line/demos/word-count/whomp.mp3
fi
