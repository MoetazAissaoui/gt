pipeline {
    agent any // You can specify a specific agent if needed
    tools {
        maven 'mvn'
        jdk 'jdk17'
    }
    stages {

        stage('Build Dependencies') {
            steps {
              echo 'Buidling application...'
                // Use the Maven wrapper to download dependencies and build the project
                sh 'cd /var/jenkins_home/workspace/asset_management_master/backend/ && mvn clean install'
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
