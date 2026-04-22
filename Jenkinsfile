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
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    bat 'gradlew.bat test'
                }
            }
        }

        stage('Coverage Report') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    bat 'gradlew.bat jacocoTestReport'
                }
            }
        }

        stage('Deploy') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    bat 'docker build -t plantuml-staging .'
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'build/libs/*.jar', fingerprint: true, allowEmptyArchive: true
            archiveArtifacts artifacts: 'build/reports/tests/test/**', allowEmptyArchive: true
            archiveArtifacts artifacts: 'build/reports/jacoco/test/html/**', allowEmptyArchive: true
            echo 'Cleaning workspace'
            deleteDir()
        }
        success {
            echo 'Build succeeded!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}
