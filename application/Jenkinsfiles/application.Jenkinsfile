pipeline {
    agent any

    environment {
        USER = 'ubuntu'
        REMOTE_HOST = '44.201.32.4'
        DEST_FOLDER = '/home/ubuntu/app'
    }

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

        stage('Build') {
            steps {
                dir('application/app-config') {
                    script {
                        sh 'npm install'
                        sh 'npm run build'
                    }
                }
            }
            post {
                success {
                    archiveArtifacts artifacts: 'application/app-config/build/'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sshagent(credentials: ['ec2-key']) {
                        script {
                            sh "ssh -o StrictHostKeyChecking=no ${USER}@${REMOTE_HOST} 'mkdir -p ${DEST_FOLDER}'"
                            sh "scp -o StrictHostKeyChecking=no -r application/app-config/build/ application/app-config/package.json ${USER}@${REMOTE_HOST}:${DEST_FOLDER}"
                            sh "ssh -o StrictHostKeyChecking=no ${USER}@${REMOTE_HOST} 'cd ${DEST_FOLDER} && npm install && sudo npm install forever -g && forever start build/index.js'"
                        }
                    }
                }
            }
        }
    }
}
