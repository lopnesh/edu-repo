pipeline {
    agent any
    stages {
        stage("Web") {
            environment {
                DOCKER-FILE = web
            }
            build 'ECRpipeline'
        }
        stage("DB") {
            environment {
                DOCKER-FILE = db
            }
            build 'ECRpipeline'
        }
        stage("DataService") {
            environment {
                DOCKER-FILE = dataservice
            }
            build 'ECRpipeline'
        }
        stage("LoadBalancer") {
            environment {
                DOCKER-FILE = loadbalancer
            }
            build 'ECRpipeline'
        }
        stage("LogService") {
            environment {
                DOCKER-FILE = logservice
            }
            build 'ECRpipeline'
        }
    }
}
