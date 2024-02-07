pipeline {
    agent any

    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'main', description: 'Git branch to checkout')
        choice(name: 'STAGE_TO_EXECUTE', choices: ['Checkout', 'Terraform Apply', 'Terraform Destroy'], description: 'Select stages to execute (comma separated)')
    }

    stages {
        stage('Checkout') {
            when {
                expression { 'Checkout' in params.STAGE_TO_EXECUTE }
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
                expression { 'Terraform Apply' in params.STAGE_TO_EXECUTE }
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
                expression { 'Terraform Destroy' in params.STAGE_TO_EXECUTE }
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
