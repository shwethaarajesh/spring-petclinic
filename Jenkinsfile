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
                withSonarQubeEnv('Sonarqube-petclinic') {
                    sh './mvnw sonar:sonar -Dsonar.projectKey=petclinic -Dsonar.projectName=PetClinic'
                }
            }
        }

        stage('Start PetClinic') {
            steps {
                sh '''
                # Start the app in the background:
                nohup java -jar target/spring-petclinic-*.jar > app.log 2>&1 &
                # Give it some time to fully start
                sleep 10
                '''
            }
        }

        stage('OWASP ZAP Scan') {
            steps {
                sh '''
                curl -X POST "http://zap:8090/JSON/ascan/action/scan/?url=http://host.docker.internal:8080&recurse=true"
                sleep 30
                curl "http://zap:8090/OTHER/core/other/htmlreport/" -o zap-report.html
                '''
            }
        }
    }

    post {
        always {
            junit 'target/surefire-reports/*.xml'

            publishHTML(target: [
                allowMissing: false,
                alwaysLinkToLastBuild: true,
                keepAll: true,
                reportDir: '.',
                reportFiles: 'zap-report.html',
                reportName: 'OWASP ZAP Report'
            ])
        }
    }
}