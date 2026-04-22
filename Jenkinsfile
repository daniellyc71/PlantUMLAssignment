pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/daniellyc71/PlantUMLAssignment.git'
            }
        }

        stage('Build') {
            steps {
                bat 'gradlew.bat clean build -x test -x javadoc'
            }
        }

        stage('Test') {
            steps {
                bat 'gradlew.bat test'
            }
        }

        stage('Coverage Report') {
            steps {
                bat 'gradlew.bat jacocoTestReport'
            }
        }

        stage('Deploy') {
            steps {
                bat 'docker build -t plantuml-staging .'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'build/libs/*.jar', fingerprint: true, allowEmptyArchive: true
            archiveArtifacts artifacts: 'build/reports/tests/test/**', allowEmptyArchive: true
            archiveArtifacts artifacts: 'build/reports/jacoco/test/html/**', allowEmptyArchive: true
            echo 'Cleaning up workspace'
            deleteDir()
        }
        success {
            echo 'Build succeeded!!!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}
