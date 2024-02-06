pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/main']],
                          userRemoteConfigs: [[url: 'https://github.com/volodymyrmedvetskyi/myproject.git',
                                               credentialsId: 'git-credentials']]])
            }
        }

        stage('Terraform') {
            steps {
                dir('application/terraform-app') {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-cred']]) {
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
    }
}
