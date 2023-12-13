Для виконання домашнього завдання використовуємо MySQL Server 8

Backup файл бази даних знаходиться у поточній теці під назвою mydatabase.sql

SQL-запит, який виводить всі проекти разом зі списком працівників, які ними керують:
SELECT Projects.ProjectID, Projects.ProjectName, Projects.StartDate, Projects.EndDate, Employees.FirstName, Employees.LastName, Employees.Position, Employees.Email 
FROM Projects JOIN Employees ON Projects.ProjectManagerID = Employees.EmployeeID;
![19](https://github.com/volodymyrmedvetskyi/myproject/assets/105160206/cdf6e6e8-6edd-4a84-a11f-b66976e3969e)

SQL-запит, який виводить всі завдання для проекту разом зі списком працівників, яким призначено ці завдання:
SELECT Tasks.TaskID, Tasks.TaskName, Tasks.DueDate, Tasks.Status, Projects.ProjectName, Projects.StartDate, Projects.EndDate, Employees.FirstName, Employees.LastName, 
Employees.Position, Employees.Email FROM Tasks JOIN Projects ON Projects.ProjectID = Tasks.ProjectID JOIN Employees ON Tasks.AssignedToID = Employees.EmployeeID 
WHERE ProjectName='Everhelp';
![20](https://github.com/volodymyrmedvetskyi/myproject/assets/105160206/09efb82a-9c80-4f19-9218-7e15d221a353)

SQL-запит, для обчислення середнього терміну виконання усіх проектів (у днях):
SELECT AVG(TIMESTAMPDIFF(DAY, StartDate, EndDate)) AS AvarageTerm FROM Projects;
![21](https://github.com/volodymyrmedvetskyi/myproject/assets/105160206/7dbfa759-b157-4014-955c-498bc98806a0)

SQL-запит, для обчислення максимального терміну виконання по кожному проекту (у днях):
SELECT Projects.ProjectName, Projects.StartDate, Projects.EndDate, MAX(DATEDIFF(EndDate, StartDate)) AS MaxTerm FROM Projects GROUP BY ProjectID;
![22](https://github.com/volodymyrmedvetskyi/myproject/assets/105160206/b84af125-3562-49fc-b009-adaf0aae88c7)
