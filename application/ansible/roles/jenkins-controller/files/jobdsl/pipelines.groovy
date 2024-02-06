// Файл конфігурації пайплайнів
pipelineJob('infrastructure/terraform') {
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://github.com/volodymyrmedvetskyi/myproject.git')
                        credentials('git-credentials')
                    }
                    branch('*/main')
                    extensions { }
                }
            }
            scriptPath('application/Jenkinsfiles/infrastructure.Jenkinsfile')
            lightweight(true)
        }
    }
}

pipelineJob('ansible/ansible') {
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://github.com/volodymyrmedvetskyi/myproject.git')
                        credentials('git-credentials')
                    }
                    branch('*/main')
                    extensions { }
                }
            }
            scriptPath('application/Jenkinsfiles/configuration.Jenkinsfile')
            lightweight(true)
        }
    }
}

pipelineJob('application/nodejs') {
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://github.com/volodymyrmedvetskyi/myproject.git')
                        credentials('git-credentials')
                    }
                    branch('*/main')
                    extensions { }
                }
            }
            scriptPath('application/Jenkinsfiles/application.Jenkinsfile')
            lightweight(true)
        }
    }
}
