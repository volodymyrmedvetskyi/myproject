pipeline {
    agent any

    environment {
        USER = 'ubuntu'
        REMOTE_HOST = '18.206.159.105'
        DEST_FOLDER = '/home/ubuntu/app'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/main']],
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
                            sh "scp -o StrictHostKeyChecking=no -r application/app-config/build/ package.json ${USER}@${REMOTE_HOST}:${DEST_FOLDER}"
                            sh "ssh -o StrictHostKeyChecking=no ${USER}@${REMOTE_HOST} 'cd ${DEST_FOLDER} && npm install && sudo npm install forever -g && forever start build/index.js'"
                        }
                    }
                }
            }
        }
    }
}