# Реплікація бази даних MySQL
Мета даного завдання полягає у створенні нової бази даних MySQL з кількома таблицями та налаштуванні майстер-слейв реплікації.
## Prerequisites
Для виконання даної роботи нам знадобляться:
* 2 віртуальні машини з OS Ubuntu 22.04
* Встановлений MySQL Server 8 на кожній віртуальній машині
## Виконання
### Створення бази даних і таблиць
Створюємо нову базу даних:
````Linux
CREATE DATABASE eStore;
````
Створюємо таблицю Clients та заповнюємо даними:
````Linux
CREATE TABLE Clients(
    -> ClientID INT AUTO_INCREMENT PRIMARY KEY,
    -> FirstName VARCHAR(50),
    -> LastName VARCHAR(50),
    -> Email VARCHAR(100)
    -> );

INSERT INTO Clients (FirstName, LastName, Email) VALUES ('Cassandra', 'Peters', 'cassandra.peters@aol.ca'),
    -> ('Madeline', 'Higgins', 'madeline.higgins@protonmail.com'),
    -> ('Ina', 'Vaughan', 'ina.vaughan@icloud.org');
````
Створюємо таблицю Orders та заповнюємо даними:
````Linux
CREATE TABLE Orders(
    -> OrderID INT AUTO_INCREMENT PRIMARY KEY,
    -> Date DATE,
    -> Description TEXT,
    -> ClientID INT,
    -> FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
    -> );

INSERT INTO Orders (Date, Description, ClientID) VALUES
    -> ('2023-11-11', 'Order for Cassandra Peters', 1),
    -> ('2023-11-29', 'Order for Madeline Higgins', 2),
    -> ('2023-11-02', 'Order for Ina Vaughan', 3);
````
Створюємо таблицю Products та заповнюємо даними:
````Linux
CREATE TABLE Products(
    -> ProductID INT AUTO_INCREMENT PRIMARY KEY,
    -> Category VARCHAR(50),
    -> Model VARCHAR(50),
    -> Price INT,
    -> Quantity INT,
    -> OrderID INT,
    -> FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
    -> );

INSERT INTO Products (Category, Model, Price, Quantity, OrderID) VALUES
    -> ('iPhone', '15 Pro Max', 55599, 3, 1),
    -> ('AirPods', 'Pro 2', 9999, 8, 2),
    -> ('MacBook', 'Air', 35999, 2, 3);
````
### Конфігурація основного сервера
У файлі /etc/mysql/my.cnf додаємо наступну конфігурацію:
````Linux
[mysqld]
bind-address = 0.0.0.0
server-id = 1
log-bin = mysql-bin
````
Перезавантажуємо mysql командою:
````Linux
sudo systemctl restart mysql.service
````
Створюємо користувача:
````Linux
CREATE USER 'replica'@'%' IDENTIFIED WITH mysql_native_password BY '<your_password>';
GRANT REPLICATION SLAVE ON *.* TO 'replica'@'%';
FLUSH PRIVILEGES;
````
Створюємо дамп бази даних:
````Linux
sudo mysqldump eStore > eStore.sql
````
### Конфігурація вторинного сервера
У файлі /etc/mysql/my.cnf додаємо наступну конфігурацію:
````Linux
[mysqld]
server-id = 2
````
Перезавантажуємо mysql командою:
````Linux
sudo systemctl restart mysql.service
````
У консолі MySQL створюємо нову базу даних:
````Linux
CREATE DATABASE eStore;
````
Імпортуємо знятий дамп бази даних:
````Linux
sudo mysql eStore < eStore.sql
````
### З'єднання slave з master та запуск реплікації
````Linux
CHANGE MASTER TO MASTER_HOST='<ip_master_host>', MASTER_USER='replica', MASTER_PASSWORD='<your_password>', MASTER_LOG_FILE='<from_master>', MASTER_LOG_POS='from_master';
START SLAVE;
````
Перевіряємо статус реплікації:
````Linux
SHOW SLAVE STATUS\G;
````
### Симуляція збою мастер сервера
Для симуляції відключаємо основний сервер. Slave сервер прийняв на себе роль мастера.
Перевіряємо командою на вторинному сервері:
````Linux
SHOW MASTER STATUS;
````