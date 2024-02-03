# Jenkins Controller Role

## Description
This role configures Jenkins as code. Creates user admin, directories, and pipelines and installs plugins.

## Usage

Use playbook jenkins-playbook.yml to execute role

```
  ansible-playbook jenkins-playbook.yml \
     -i inventory.ini \
     --extra-vars "jenkins_ip=<put jenkins server IP>" \
     --diff --check
```

## useful links

[Jcasc docs](https://www.jenkins.io/projects/jcasc/)  
[Jenkins Pipelines](https://www.jenkins.io/doc/book/pipeline/)  
[Jenkins plugins](https://plugins.jenkins.io/)  
[Jenkins Groovy scripts](https://medium.com/@guvercin.ersin/groovy-script-and-jenkins-7addaa44716f)  

