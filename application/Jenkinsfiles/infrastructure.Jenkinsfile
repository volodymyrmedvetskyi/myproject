pipeline {
    agent any

    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'main', description: 'Git branch to checkout')
        string(name: 'STAGES_TO_EXECUTE', defaultValue: 'Checkout', description: 'Select stages to execute (comma separated)')
    }

    stages {
        stage('Checkout') {
            when {
                expression { params.STAGES_TO_EXECUTE.contains('Checkout') }
            }
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/$BRANCH_NAME']],
                          userRemoteConfigs: [[url: 'https://github.com/volodymyrmedvetskyi/myproject.git',
                                               credentialsId: 'git-credentials']]])
            }
        }

        stage('Terraform Apply') {
            when {
                expression { params.STAGES_TO_EXECUTE.contains('Terraform Apply') }
            }
            steps {
                dir('application/terraform-app') {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-cred']]) {
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.STAGES_TO_EXECUTE.contains('Terraform Destroy') }
            }
            steps {
                dir('application/terraform-app') {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-cred']]) {
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }
    }
}
