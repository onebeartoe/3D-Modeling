
pipeline 
{
  agent any

  environment{
    OPENSCAD_PATH = "/snap/bin/openscad"
  }

  stages {
    stage('clean') {
      steps {
        echo 'Cleaning...'
        sh '''
                mvn clean
           '''
      }
    }
    stage('install') {
      steps {
        echo 'Verifying...'
        sh '''
                whoami
                java -version
                /snap/bin/openscad --help
                mvn verify
           '''
      }
    }
  }
}
