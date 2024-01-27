# Впровадження Ansible
Мета даного завдання полягає у створенні Ansible playbooks з використанням ролей.
## Prerequisites
Для виконання даної роботи нам знадобляться:
* Віртуальна машина з OS Ubuntu 22.04
* Встановлений локально Ansible
* WSL, якщо завдання виконується на OS Windows
## Встановлення локально Ansible
Для встановлення Ansible на OS Windows, необхідно з підсистеми Linux (WSL) виконати наступні команди:
````Linux
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
````
## Використання Ansible playbooks
Перед початком роботи з playbooks у файлі inventory.ini необхідно вказати власну IP-адресу віддаленого сервера, ім'я користувача для цього сервера та використовувати власний приватний ключ.

Для успішного додавання публічного ключа у файл authorized_key на віддаленому сервері, необхідно згенерувати власну пару ключів командою:
````Linux
ssh-keygen
````
Згенероване значення публічного ключа необхідно вказати у файлі roles/user_config/defaults/main.yml 

Для запуску бажаного playbook необхідно виконати наступну команду:
````Linux
ansible-playbook -i inventory.ini <playbook_name>
````
