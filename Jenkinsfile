pipeline {
  environment {
    registry = "mangeshdevops/jenkins-docker-demo"
    registryCredential = 'mangeshdevops'
    dockerImage = ''
    commit_id = ''
  }
  agent any
  stages {
  	stage('clean workspace') {
  	  steps {
  	  	cleanWs()
  	  }
  	}
  	
    stage('gitcheckout') {
      steps {
        git(credentialsId: 'MangeshShinde91', url: 'https://github.com/MangeshShinde91/devops-jenkins-docker-pipeline-demo.git', branch: 'master', poll: true)
      }
    }
    
    stage('Retrive Commit ID') {
      steps {
        sh "git rev-parse --short HEAD > .git/commit-id"                        
        commit_id = readFile('.git/commit-id').trim()
        echo commit_id
      }
    }

    stage('Clean Code') {
      steps {
        sh 'mvn clean'
      }
    }

    stage('Compile Code') {
      steps {
        sh 'mvn compile'
      }
    }

    stage('Test Code') {
      steps {
        sh 'mvn test'
      }
    }

    stage('Package Code') {
      steps {
        sh 'mvn package'
      }
    }

    stage('Verify Code') {
      steps {
        sh 'mvn verify'
      }
    }

    stage('Install Code') {
      steps {
        sh 'mvn install'
      }
    }
    
    stage('Build Docker Image') {
      steps {
        script {
          dockerImage = docker.build registry + ":${commit_id}"
        }
      }
    }
    
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    
    stage('Run Container') {
      steps{
        script {
          dockerImage.withRun('-p 8585:8585') {c ->
		    sh "curl -i http://${hostIp(c)}:8585/"
		  }
        }
      }
    }
  }
  post {
  	always {
  		cleanWs(cleanWhenNotBuilt: false,
                    deleteDirs: true,
                    disableDeferredWipeout: true,
                    notFailBuild: true,
                    patterns: [[pattern: '.gitignore', type: 'INCLUDE'],
                               [pattern: '.propsfile', type: 'EXCLUDE']])
  	}
  }
}