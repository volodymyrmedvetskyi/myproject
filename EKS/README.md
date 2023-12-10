Для виконання домашнього завдання використовуємо конфігураційні файли з попереднього ДЗ (файли додано у поточну теку з назвами app-deployment.yml mysql-secrets.yml та
mysql-deployment.yml). Зміни були внесені лише у файл app-deployment.yml у об'єкті Service для зміни типу сервісу з NodePort на LoadBalancer, для перевірки працездатності.
Домашнє завдання було виконано за допомогою сервісу EKS, тому, для виконання ДЗ було окремо піднято віртуальну машину для управління кластером та 2 віртуальні машини
всередині самого кластера. Кластер піднято командою:
eksctl create cluster --name my-eks-cluster --region us-east-1 --nodegroup-name my-eks-nodegroup --node-type t3.small --managed --nodes 2
![12](https://github.com/volodymyrmedvetskyi/myproject/assets/105160206/2c4b6401-add5-439d-ab1a-80077291910d)
1. Prometheus та Grafana були взяті з репозиторію Helm
![13](https://github.com/volodymyrmedvetskyi/myproject/assets/105160206/a846ea27-1947-40dd-8639-2dc7700561df)
Для доступу до Prometheus та Grafana з браузера було змінено об'єкт Service на тип LoadBalancer 
![14](https://github.com/volodymyrmedvetskyi/myproject/assets/105160206/7d7f7a61-caa9-4996-b941-59cb6740b961)
Інтерфейс Prometheus:
![15](https://github.com/volodymyrmedvetskyi/myproject/assets/105160206/bd0b4a41-c341-4317-9b7a-f2b15ba66586)
Інтерфейс Grafana:
![16](https://github.com/volodymyrmedvetskyi/myproject/assets/105160206/cd8c8516-c380-4374-aa78-7f92278f8f13)

Після чого, використовуючи конфігураційні файли з минулого домашнього завдання, було піднято 2 репліки додатку та 1 репліку бази даних. Спробували підключитись до застосунку
через load balancer, все працює:
![17](https://github.com/volodymyrmedvetskyi/myproject/assets/105160206/cb4ee2ea-e544-4ff4-9fe6-82e7a08d4a3a)

Було використано існуючий шаблон дашборду для моніторингу кластеру Kubernetes, точніше саме подів. Для прикладу, нижче наведено скріншот пропускної здатності застосунку
на одній із под:
![18](https://github.com/volodymyrmedvetskyi/myproject/assets/105160206/c54d3596-7964-4159-8713-da79a98417b1)




