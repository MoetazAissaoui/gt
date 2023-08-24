pipeline {
    agent any // You can specify a specific agent if needed
    tools {
        maven 'mvn'
    }
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
                sh 'mvn clean install .//var/jenkins_home/workspace/asset_management_master/backend/pom.xml' // Use mvnw.cmd on Windows
            }
        }

    }

    post {
        success {
           echo 'Pipeline success.'
        }

        failure {
            echo 'Pipeline fail.'
        }
    }
}
