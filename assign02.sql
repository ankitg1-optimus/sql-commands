--creating and using database
create database assign2;
use assign2;

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


-- data insertion
INSERT INTO Departments VALUES ( 'Cloud', 'Delhi'),
								( 'Web Development', 'Noida'),
								( 'Data Analyst', 'Mohali'),
								('HR', 'Mumbai'),
								('QA', 'Noida');

INSERT INTO Employees VALUES ('Harsh', 'Verma', 2001,90000, '2023-08-11'),
							 ('Alice', 'Kims', 2002, 45000, '2023-11-17'),
							 ('Anand', 'Sharma', 2000, 119000, '2024-08-09'),
							 ('Richard', 'Johnson', 2001, 76000, '2019-04-14'),
							 ('Lisa', 'Gurung', 2001, 88000, '2019-08-15'),
							 ('Sanskriti', 'Rawat', 2002, 50000, '2024-10-01'),
							 ('Kizeo', 'Riff', 2003, 48000, '2024-10-01'),
							 ('Ruru', 'Singh', 2004, 70000, '2021-09-04'),
							 ('Abish', 'Nick', 2000, 90000, '2021-09-04'),
							 ('Alex','Peter',  2004, 112000, '2018-03-15');

INSERT INTO Projects VALUES ('Meeting App', 4500, 205),
							('Azure Solutions', 4502 , 290),
							('AWS Certifications',4508,366),
							('Business Growth', 4505, 120),
							('Startup Website', 4503, 293),
							('Freshers Hiring', 4504, 251),
							('Estate Marketing', 4507, 190),
							('Salary Increment', 4501, 253);
--see raw tables

Select * from Departments;
Select * from Employees;
Select * from Projects;

--
Select ep.first_name, 
	ep.last_name,
	ep.department_name,
	ep.salary,
	ep.salary_rank,
	ep.project_hours,  --extracting column from inner subquery that filtered some data based on given conditions
	case 
		when project_hours >150 then 'Star Performer'
		when project_hours  between 101 and 150 then 'Good Performer'
	end as Performance_category --performance category column added using case statement on basis of project hours
from 
( ---subquery that is processing all condition required
	Select e.first_name, 
		e.last_name,
		(Select department_name from --subquery to get deptName
			(Select department_id from( --subquery to get deptId
				Select Departments.department_id,Sum(project_hours) as[Total Working Hours] from Departments  
				Left JOIN Employees ON Employees.department_id = Departments.department_id   --- joining employee -> dept
				JOIN Projects on Employees.employee_id =Projects.employee_id     --- joining projects -> employee
				group by Departments.department_id having Sum(project_hours)>500)  -- grouping departments and checking conditon  
				as d where e.department_id = d.department_id )
			as sortedD 
			Join Departments on Departments.department_id = sortedD.department_id) -- again applied join to extract department name
		as department_name, 
		e.salary, 
		(Select p.project_hours from Projects as p where p.employee_id = e.employee_id) ---picks project_hours from projects table
		as project_hours,
		ROW_NUMBER()over(partition by department_id order by salary DESC) as salary_rank --giving rank on the basis of salary within each department
		from Employees as e) 
	as ep
where ep.project_hours>100   --checking for project hours of each employee to be more than 100 
and 
department_name is not null   --checking for department to not be null

Order by ep.department_name, ep.salary DESC; ---sorting data on the basis of dept name and if same then on the basis of salary 

