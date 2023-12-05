Опис до домашки Docker:
1. Було створено 2 Dockerfiles (на одному налоштовано веб-сервер nginx, на другому apache). Додано до репозиторію у теках dockerproject1 та dockerproject2.
2. Створено docker-compose.yml та додано до репозиторію у теці DockerCompose. Для задачі з docker compose було обрано приклад з документації докер, для більш чіткої роботи залежності між двома контейнерами.
3. Контейнери перевірені - все працює

Опис до домашки DockerSwarm:
1. Для виконання домашнього завдання, щоб побудувати Docker images, було обрано Dockerfiles з минулого домашнього завдання по Docker. Images контейнерів мають незалежні сервіси, які працюють на різних портах (трощки було змінено номери портів у порівняння з минулим завданням). Для одного контейнеру відкрили порт 80, для другого 81.
2. Створено 2 репозиторії на DockerHub та командою docker push залили туди створені images. Посилання на DockerHub https://hub.docker.com/repositories/volodymyrmedvetskyi (репозиторії з назвами webapp1 та webapp2)
3. Створено 3 віртуальні машини на AWS, за допомогою скрипта встановили та налаштували docker та docker-compose, обрали master ноду, змінили налаштування в Security group для перевірки працездастності наших сервісів.
4. На master ноді було створено docker-compose.yml файл, який додано до репозиторію у теку DockerSwarm, images вказуємо з раніше створених репозиторіїв, мережа вказана як overlay, інакше docker swarm не дозволяв створити окрему мережу для кожного веб-додатку.
5. Командою docker stack deploy піднімаємо контейнери (4 репліки). Docker swarm автоматично розподіляє контейнери по 3 віртуальним машинам.
6. Перевірили працездатність контейнерів на кожній з віртуальних машин - все працює. Ініціювали відключення однієї віртуальної машини - docker swarm успішно підняв відсутні контейнери.

Опис до занняття #12 (Kubernetes):
1. Було створено 2 віртуальні машини в AWS. Одна виконує роботу master ноди, друга - worker нода, для утворення кластеру.
2. Встановлення та конфігурація kubernetes було зроблено за допомогою скрипта (скрипт знаходиться у теці Kubernetes)
3. Після налаштування Kubernetes ініціалізуємо створення кластеру на мастер ноді командою sudo kubeadm init --control-plane-endpoint=k8smaster, де k8smaster - ім'я хоста, яке ми змінили
4. Далі виконуємо команди згідно інструкції, яку нам пропонує Kubernetes після ініціалізації кластера. На worker ноді запускаємо команду для додавання в кластер:
![1](https://github.com/volodymyrmedvetskyi/myproject/assets/105160206/57337d17-b7f2-41f2-82bc-073e1466de85)
5. Командою kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml встановлюємо мережевий плагін для зв'язку між хостами.
6. Переходимо саме до вимог домашнього завдання. Командою kubectl create namespace customns створюємо власний namespace.
7. Створюємо secret в раніше створеному namespace в якому вказуємо root пароль, ім'я бази даних, ім'я звичайного користувача та його пароль командою kubectl create secret generic db-secret --from-literal=MYSQL-ROOT-PASSWORD=rootpass123 --from-literal=MYSQL-DATABASE=mydb --from-literal=MYSQL-USER=dbuser --from-literal=MYSQL-PASSWORD=dbuserpass123 --namespace=customns . Перевіряємо коректність створення:
![2](https://github.com/volodymyrmedvetskyi/myproject/assets/105160206/51a816e4-9585-4fa1-8633-df1486b3d649)
8. Запускаємо поду з nginx в раніше створеному namespace командою kubectl run nginx --image=nginx -n customns . Дана команда запускає один одноразовий контейнер. Можна було створити через deployment, але обрав такий варіант для тестування :) Командою kubectl expose pod nginx --type=NodePort --port=80 -n customns відкриваємо порт для доступу через браузер до нашого застосунка. Рандомно випав порт 31436, тому цей порт такоє відкриваємо в security group в AWS. Скріншоти підтвердження коректної роботи нижче
![3](https://github.com/volodymyrmedvetskyi/myproject/assets/105160206/1ad7543d-0fa3-4c76-ab1a-f7fa8ac5cf7b)
![4](https://github.com/volodymyrmedvetskyi/myproject/assets/105160206/7f1317eb-a1e3-4ea4-95ce-8c11b7d28490)
9. Запускаємо поду з mysql в раніше створеному namespase та використовуючи раніше створений secret командою kubectl run mysqldb --image=mysql:latest --env="MYSQL_ROOT_PASSWORD=$(kubectl get secret db-secret -n customns -o jsonpath='{.data.MYSQL-ROOT-PASSWORD}' | base64 -d)" --env="MYSQL_DATABASE=$(kubectl get secret db-secret -n customns -o jsonpath='{.data.MYSQL-DATABASE}' | base64 -d)" --env="MYSQL_USER=$(kubectl get secret db-secret -n customns -o jsonpath='{.data.MYSQL-USER}' | base64 -d)" --env="MYSQL_PASSWORD=$(kubectl get secret db-secret -n customns -o jsonpath='{.data.MYSQL-PASSWORD}' | base64 -d)" -n customns
![5](https://github.com/volodymyrmedvetskyi/myproject/assets/105160206/88817e58-09b6-4fa9-a87a-adb39beb4fdd)
![6](https://github.com/volodymyrmedvetskyi/myproject/assets/105160206/41664cf0-3798-4558-97d3-98146f70bf43)
10. Для перевірки коректності роботи бази даних спробуємо підключитись всередину самого контейнера інтерективно та зайти на базу даних, використовуючи облікові дані, які були вказані в Secret. Для успішного підключення потрібно в AWS в Security group додати порт 10250. Вводимо команду kubectl exec -it mysqldb -n customns -- /bin/bash . В нашому випадку все спрацювало і база працює коректно. Скріншот нижче:
![7](https://github.com/volodymyrmedvetskyi/myproject/assets/105160206/ec291cf8-34f7-480e-bf25-e2ba07117da1)
11. Всі створені ресурси видаляємо командою kubectl delete 
![8](https://github.com/volodymyrmedvetskyi/myproject/assets/105160206/45309051-30b6-471d-913a-c707f2ebd798)






