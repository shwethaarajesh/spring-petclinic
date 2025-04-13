pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Jenkins automatically checks out, but we can do this explicitly
                git url: 'https://github.com/shwethaarajesh/spring-petclinic.git', branch: 'main'
            }
        }
        stage('Build') {
            steps {
                sh './mvnw clean package'
            }
        }
        stage('Test') {
            steps {
                sh './mvnw test'
            }
        }
    }
}