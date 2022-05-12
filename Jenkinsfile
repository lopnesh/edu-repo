pipeline {
    agent {
      label 'docker-in-docker'
    }
    stages {
        stage("Web") {
            steps {
                build job: 'ECRpipeline', parameters: [
                string(name: 'FILENAME', value: 'web')
                ]
            }
        }
        stage("DB") {
            steps {
                build job: 'ECRpipeline', parameters: [
                string(name: 'FILENAME', value: 'db')
                ]
            }
        }
        stage("DataService") {
            steps {
                build job: 'ECRpipeline', parameters: [
                string(name: 'FILENAME', value: 'dataservice')
                ]
            }
        }
        stage("LoadBalancer") {
            steps {
                build job: 'ECRpipeline', parameters: [
                string(name: 'FILENAME', value: 'loadbalancer')
                ]
            }
        }
        stage("LogService") {
            steps {
                build job: 'ECRpipeline', parameters: [
                string(name: 'FILENAME', value: 'logservice')
                ]
            }
        }
    }
}
