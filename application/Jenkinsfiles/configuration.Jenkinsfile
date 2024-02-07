pipeline {
    agent any

    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'main', description: 'Git branch to checkout')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/$BRANCH_NAME']],
                          userRemoteConfigs: [[url: 'https://github.com/volodymyrmedvetskyi/myproject.git',
                                               credentialsId: 'git-credentials']]])
            }
        }

        stage('Node.js configuration') {
            steps {
                dir('application/ansible') {
                    sshagent(credentials: ['ec2-key']) {
                        sh 'ansible-playbook -i inventory.ini app-playbook.yml'
                    }
                }
            }
        }
    }
}