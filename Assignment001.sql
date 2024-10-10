--creating database for company details
create database Company_Details;
use Company_Details;

--creating tables for storing data
CREATE TABLE Departments(
	department_id INT PRIMARY KEY IDENTITY(2000,1),
	department_name VARCHAR(255),
	location VARCHAR(255),
)

CREATE TABLE Employees(
	employee_id INT PRIMARY KEY IDENTITY(4500,1),
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	department_id INT FOREIGN KEY REFERENCES Departments(department_id),
	salary decimal,
	hire_date date
)

CREATE TABLE Projects(
	project_id INT PRIMARY KEY IDENTITY(7250,1),
	project_name VARCHAR(255),
	employee_id INT FOREIGN KEY REFERENCES Employees(employee_id),
	project_hours INT
)


-- Part 1
INSERT INTO Departments VALUES ( 'Cloud', 'Delhi'),
								( 'Web Development', 'Noida'),
								( 'Data Analyst', 'Mohali');

INSERT INTO Employees VALUES ('Harsh', 'Verma', 2001,90000, '2023-08-11'),
							 ('Alice', 'Kims', 2002, 45000, '2023-11-17'),
							 ('Anand', 'Sharma', 2000, 119000, '2024-08-09'),
							 ('Richard', 'Johnson', 2001, 76000, '2019-04-14'),
							 ('Lisa', 'Gurung', 2001, 88000, '2019-08-15'),
							 ('Sanskriti', 'Rawat', 2002, 50000, '2024-10-01');

INSERT INTO Projects VALUES ('Meeting App', 4501, 120),
							('Azure Solutions', 4502 , 90),
							('Business Growth', 4505, 70),
							('Startup Website', 4504, 83);
--see raw tables

Select * from Departments;
Select * from Employees;
Select * from Projects;

update projects set employee_id = 4500 where project_id = 7500
-- Part 2
Select first_name+' '+ last_name AS [Empolyee Name], department_name as [Department Name]
from Employees
JOIN Departments ON Employees.department_id = Departments.department_id;

Select first_name+' '+ last_name AS [Empolyee Name], ISNULL(project_name, 'Not Assigned') as [Project Name]
from Employees
LEFT JOIN Projects ON Employees.employee_id = Projects.employee_id;

--Part 3

Select  first_name+' '+ last_name AS [Empolyee Name], salary from Employees
where salary>50000; 

Select  first_name+' '+ last_name AS [Empolyee Name] from Employees
where DATEDIFF(yy,hire_date,GetDate()) <=3;

--Part 4

Select department_name, Sum(project_hours) as[Total Working Hours] from Departments
LEFT JOIN Employees ON Employees.department_id = Departments.department_id 
JOIN Projects on Employees.employee_id =Projects.employee_id
group by department_name;

Select department_name, Sum(project_hours) as [Total Working Hours] from Departments
LEFT JOIN Employees ON Employees.department_id = Departments.department_id 
JOIN Projects on Employees.employee_id =Projects.employee_id
group by department_name having Sum(project_hours)>100;

-- Part 5


Select first_name+' '+ last_name AS [Empolyee Name], salary, department_name , ROW_NUMBER()over(Partition by Employees.department_id order by salary desc ) as Ranking
from Employees JOIN 
Departments on Employees.department_id = Departments.department_id
order by Employees.department_id; 


-- Part 6

Select first_name+' '+ last_name AS [Empolyee Name], salary , 
case
	when salary>80000 then 'HIGH'
	when salary BETWEEN 50000 AND 80000 then 'MEDIUM'
	ELSE 'LOW'
end as Category
from Employees;


