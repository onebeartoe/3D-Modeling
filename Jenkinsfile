
pipeline 
{
  agent any
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
                openscad --help
                mvn verify
           '''
      }
    }
  }
}
