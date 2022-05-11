pipeline {
    agent any
    environment {
        registry = "086913749727.dkr.ecr.eu-central-1.amazonaws.com/test"
    }
   
    stages {
        stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/lopnesh/edu-repo/']]])     
            }
        }
  
    // Building Docker images
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry
        }
      }
    }
   
    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
     steps{  
         script {
                sh 'aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 086913749727.dkr.ecr.eu-central-1.amazonaws.com'
                sh 'docker push 086913749727.dkr.ecr.eu-central-1.amazonaws.com/test:latest'
         }
        }
      }
   
         // Stopping Docker containers for cleaner Docker run
     stage('stop previous containers') {
         steps {
            sh 'docker ps -f name=mypythonContainer -q | xargs --no-run-if-empty docker container stop'
            sh 'docker container ls -a -fname=mypythonContainer -q | xargs -r docker container rm'
         }
       }
      
    stage('Docker Run') {
     steps{
         script {
                sh 'docker run -d -p 8096:5000 --rm --name mypythonContainer 086913749727.dkr.ecr.eu-central-1.amazonaws.com/test:latest'
            }
      }
    }
    }
}
