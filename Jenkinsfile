pipeline {
  environment {
    registry = "mangeshdevops/jenkins-docker-demo"
    registryCredential = 'mangeshdevops'
    dockerImage = ''
    commit_id = ''
    host_ip = ''
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
        script {
          sh "git rev-parse --short HEAD > .git/commit-id"                        
          commit_id = readFile('.git/commit-id').trim()
          echo commit_id
        }
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
          dockerImage.withRun('-p 8484:8484 --name container' + ${commit_id}) {c ->
            sh "curl http://checkip.amazonaws.com > .git/host_ipaddr"
            host_ip = readFile('.git/host_ipaddr').trim()
            sh "curl http://${host_ip}:8484/greeting"
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