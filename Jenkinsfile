pipeline {
  agent any
  stages {
    stage('gitcheckout') {
      steps {
        git(credentialsId: 'MangeshShinde91', url: 'https://github.com/MangeshShinde91/devops-jenkins-docker-pipeline-demo.git', branch: 'master', poll: true)
      }
    }

  }
}