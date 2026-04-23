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
                bat 'echo @startuml > sample.puml'
                bat 'echo Alice -> Bob: Hello from Jenkins >> sample.puml'
                bat 'echo @enduml >> sample.puml'
                bat 'java -jar build\\libs\\plantuml-1.2026.3beta8.jar sample.puml'
                bat 'dir'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'build/libs/*.jar', fingerprint: true, allowEmptyArchive: true
            archiveArtifacts artifacts: 'build/reports/tests/test/**', allowEmptyArchive: true
            archiveArtifacts artifacts: 'build/reports/jacoco/test/html/**', allowEmptyArchive: true
            archiveArtifacts artifacts: '*.png', allowEmptyArchive: true
            archiveArtifacts artifacts: '*.puml', allowEmptyArchive: true
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
