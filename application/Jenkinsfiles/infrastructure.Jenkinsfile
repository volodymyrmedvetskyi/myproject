pipeline {
    agent any

    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'main', description: 'Git branch to checkout')
        choice(name: 'STAGE_TO_EXECUTE', choices: ['Checkout', 'Terraform Apply', 'Terraform Destroy'], description: 'Select stages to execute')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/${params.BRANCH_NAME}']],
                          userRemoteConfigs: [[url: 'https://github.com/volodymyrmedvetskyi/myproject.git',
                                               credentialsId: 'git-credentials']]])
            }
        }

        stage('Terraform Apply') {
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