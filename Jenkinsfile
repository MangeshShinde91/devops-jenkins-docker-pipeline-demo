pipeline {
  agent any
  stages {
    stage('gitcheckout') {
      steps {
        git(credentialsId: 'MangeshShinde91', url: 'https://github.com/MangeshShinde91/devops-jenkins-docker-pipeline-demo.git', branch: 'master', poll: true)
      }
    }

    stage('cleancode') {
      steps {
        sh 'mvn clean'
      }
    }

    stage('compilecode') {
      steps {
        sh 'mvn compile'
      }
    }

    stage('testcode') {
      steps {
        sh 'mvn test'
      }
    }

    stage('packagecode') {
      steps {
        sh 'mvn package'
      }
    }

    stage('verifycode') {
      steps {
        sh 'mvn verify'
      }
    }

    stage('installcode') {
      steps {
        sh 'mvn install'
      }
    }

  }
}