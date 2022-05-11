pipeline {
    agent any
    stages {
        stage("Web") {
            steps {
                build job: 'ECRpipeline', parameters: [
                string(name: 'FILENAME', value: "web"), propagate: true, wait: true
                ]
            }
        }
        stage("DB") {
            steps {
                build job: 'ECRpipeline', parameters: [
                string(name: 'FILENAME', value: "db"), propagate: true, wait: true
                ]
            }
        }
        stage("DataService") {
            steps {
                build job: 'ECRpipeline', parameters: [
                string(name: 'FILENAME', value: "dataservice"), propagate: true, wait: true
                ]
            }
        }
        stage("LoadBalancer") {
            steps {
                build job: 'ECRpipeline', parameters: [
                string(name: 'FILENAME', value: "loadbalancer"), propagate: true, wait: true
                ]
            }
        }
        stage("LogService") {
            steps {
                build job: 'ECRpipeline', parameters: [
                string(name: 'FILENAME', value: "logservice"), propagate: true, wait: true
                ]
            }
        }
    }
}
