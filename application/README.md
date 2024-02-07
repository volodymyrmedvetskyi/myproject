# IaC з використанням AWS

Метою даного завдання є розгортання інфраструктури в AWS за допомогою Terraform, конфігурація створених серверів за допомогою Ansible та розгортання веб-застосунку на сервері за допомогою Jenkins.

## Prerequisites

Для успішного виконання завдання необхідно слідувати наступним вимогам:
* локально встановлена остання версія Terraform
* локально встановлена остання версія Ansible
* локально згенерована пара ключів (публічний і приватний)

## Створення інфраструктури для Jenkins сервера

Файли конфігурації для розгортання інфраструктури для Jenkins сервера (VPC, Subnets, EC2, etc) знаходяться у теці з назвою terraform.
Перед запуском, необхідно додати локально згенеровану пару ключів у поточну теку.
Приватний ключ буде використовуватись для доступу до Jenkins сервера, публічний ключ буде додано на Jenkins сервер та сворений за допомогою AWS ресурсу "aws_key_pair". Необхідно переконатись, що назва публічного ключа у поточній теці співпадає з іменем публічного ключа, що вказано у ресурсі (terraform/modules/server/main.tf змінити строки 7, 16, 17).

Для ініціалізації Terraform виконуємо наступну команду:
````
terraform init
````
Перевіряємо, які саме ресурси будуть створені, командою:
````
terraform plan
````
Створюємо інфраструктуру виконавши наступну команду:
````
terraform apply
````

## Конфігурація Jenkins сервера за допомогою Ansible

Конфігураційні файли для запуску Ansible знаходяться у теці ansible.
Для конфігурації Jenkins сервера використовуємо playbook з назвою jenkins-playbook.yml, роль для цього playbook з назвою jenkins-controller.
Перед запуском playbook необхідно створити зашифрований roles/jenkins-controller/defaults/main/<файл_з_паролями>.yml файл:
````
ansible-vault create roles/jenkins-controller/defaults/main/<назва_файлу>.yml
````
вказати пароль та додати наступний текст з власними значеннями:
````
jenkins_admin_username: <ім'я_користувача_до_Jenkins>
jenkins_admin_password: <пароль_користувача_до_Jenkins>
git_credentials: <git_token>
access_key: <AWS_Access_Key>
secret_key: <AWS_Secret_Key>
````
За замовчування, Ansible зчитує всі файли, що вказані у defaults/main/

У файлі roles/jenkins-controller/files/jobdsl/pipelines.groovy прописаний шлях до кожного pipeline з власного репозиторію. Ці ж pipelines прописані у теці Jenkinsfiles.

У файлі roles/jenkins-controller/templates/ec2-key.j2 необхідно вставити значення раніше стореного приватного ключа. Даний ключ буде використовуватись у pipeline для підключення до серверів і їх конфігурації за допомогою Ansible.

У inventory.ini файлі у групі jenkins_controller вказуємо публічний IP address раніше створенного сервера та шлях до приватного ключа для підключення до серверу.

Запускаємо playbook для конфігурації Jenkins сервера наступною командою:
````
  ansible-playbook jenkins-playbook.yml \
     -i inventory.ini \
     --extra-vars "jenkins_ip=<вкажіть IP>" \
     --diff --ask-vault-pass
````
та вводимо пароль, який ми вказували при створенні roles/jenkins-controller/defaults/main/<назва_файлу>.yml файлу.

## Підключення до Jenkins серверу

Після виконання playbook ми можемо підключитись до зконфігурованого Jenkins серверу:
````
<ip_address>:8080
````
Для входу на сервер використовуємо вказані у roles/jenkins-controller/defaults/main/<назва_файлу>.yml файлі логін і пароль (значення jenkins_admin_username та jenkins_admin_password).

На сервері вже будуть готові сконфігуровані Jenkins pipelines.

## Створення інфраструктури для application сервера

Pipeline для створення інфраструктури для application сервера знаходиться у infrastructure/terraform.

Файли конфігурації для запуску Terraform знаходяться у теці terraform-app - майже з ідентичною конфігурацією, з різницею у тегах для application сервера і додванням порта 3000 у security group.

## Конфігурація серверів за допомогою Ansible

Pipeline для конфігурації серверів знаходиться у ansible/ansible.

Конфігураційні файли знаходяться у теці ansible/

Для конфігурації серверів використовується playbook з назвою app-playbook.yml, роль для цього playbook з назвою nodejs.

У inventory.ini файлі у групі application вказуємо публічний IP address попередньо створенного сервера.

## Розгортання застосунку

Pipeline для збірки та розгортання застосунку знаходиться у application/nodejs.

Конфігураційні файли застосунку знаходяться у теці app-config/

У Pipeline перед запуском у модулі environment необхідно вказати IP address створеного application сервера.

Щоб перевірити працездатність застосунку використовуємо публічний IP address application сервера та порт 3000:
````
<ip_address>:3000
````


