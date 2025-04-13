pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/shwethaarajesh/spring-petclinic.git', branch: 'main'
            }
        }

        stage('Build') {
            steps {
                sh './mvnw clean package -DskipTests=true'
            }
        }

        stage('Test') {
            steps {
                sh './mvnw test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                // "My SonarQube Server" matches the name you configured in Jenkins -> Configure System -> SonarQube servers
                withSonarQubeEnv('Sonarqube-petclinic') {
                    sh """
                      ./mvnw sonar:sonar \\
                      -Dsonar.projectKey=petclinic \\
                      -Dsonar.projectName=PetClinic \\
                      -Dsonar.host.url=\${env.SONAR_HOST_URL} \\
                      -Dsonar.login=\${env.SONAR_AUTH_TOKEN}
                    """
                }
            }
        }
    }

    post {
        always {
            // Archive test reports so you can see pass/fail trends in Jenkins
            junit 'target/surefire-reports/*.xml'
        }
    }
}