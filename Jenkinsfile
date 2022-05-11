pipeline {
    agent any
    stages {
        stage("Web") {
            environment {
                FILENAME = web
            }
            build 'ECRpipeline'
        }
        stage("DB") {
            environment {
                FILENAME = db
            }
            build 'ECRpipeline'
        }
        stage("DataService") {
            environment {
                FILENAME = dataservice
            }
            build 'ECRpipeline'
        }
        stage("LoadBalancer") {
            environment {
                FILENAME = loadbalancer
            }
            build 'ECRpipeline'
        }
        stage("LogService") {
            environment {
                FILENAME = logservice
            }
            build 'ECRpipeline'
        }
    }
}
