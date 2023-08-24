pipeline {
    agent any // You can specify a specific agent if needed

    stages {
        stage('Checkout') {
            steps {
              echo 'Checkouting branche...'
                // Checkout the source code from your version control system (e.g., Git)
                checkout scm
            }
        }

        stage('Build Dependencies') {
            steps {
              echo 'Buidling application...'
                // Use the Maven wrapper to download dependencies and build the project
                sh './mvnw clean install' // Use mvnw.cmd on Windows
            }
        }

    }

    post {
        success {
            // This block is executed if all stages are successful
            // You can perform additional actions here if needed
        }

        failure {
            // This block is executed if any stage fails
            // You can perform cleanup or notification actions here if needed
        }
    }
}
