create table employees( employee_id int PRIMARY KEY identity(2000,1),
name varchar(255), department_id int Foreign key References departments(department_id), hire_date date);

create table departments (department_id int PRIMARY KEY identity (101,1),
department_name varchar(255));

create table sales(sale_id INT PRIMARY KEY identity (4140,1), 
employee_id  int Foreign Key References employees(employee_id), 
sale_date date, amount decimal);

create table performance_reviews(review_id int PRIMARY KEY identity(2750,1), 
employee_id INT FOREIGN KEY REFERENCES employees(employee_id), review_date date, 
score INT);

Insert into employees values ('Harish', 101, '2021-11-01'),
							('Lisa', 102, '2021-05-05'),
							('Alex', 101, '2022-02-22'),
							('Priya', 102, '2021-12-17'),
							('Ramesh', 102, '2021-01-04'),
							('Betly', 101, '2021-10-09'),
							('Victoria', 101, '2021-08-19'),
							('Uma', 102, '2022-04-14'),
							('Harlett', 103, '2021-09-09'),
							('Lincon', 103, '2021-07-16'),
							('Kimmy', 103, '2021-10-09'),
							('Nana', 103, '2023-10-13'),
							('Foxy', 104, '2021-02-09'),
							('Xlisa', 104, '2021-10-07'),
							('Tenzing', 104, '2021-10-09'),
							('Peter', 104, '2021-01-08'),
							('Gord',105, '2022-03-12'),
							('Gusion',105, '2021-06-11'),
							('Aamon',105, '2022-05-29'),
							('Linx',105, '2022-06-12');

Insert into departments values ( 'Mens Clothing'),
							('Girls Clothing'),('Toys'),('HouseHold'),('Electronics');

Insert into sales values (2000,'2023-11-01',3000),
						 (2000,'2023-12-01',4000),
						 (2001,'2024-01-19',1000),
						 (2002,'2019-11-09',1500),
						 (2003,'2023-12-11',4500),
						 (2004,'2023-11-01',1500),
						 (2004,'2023-12-01',2000),
						 (2005,'2024-01-19',1000),
						 (2006,'2019-11-09',1600),
						 (2007,'2023-12-11',4900),
						 (2008,'2023-11-01',1800),
						 (2009,'2023-12-01',1700),
						 (2009,'2024-01-19',1200),
						 (2010,'2019-11-09',1900),
						 (2011,'2023-12-11',3500),
						 (2012,'2023-11-01',3000),
						 (2013,'2023-12-01',8500),
						 (2014,'2024-01-19',1900),
						 (2014,'2019-11-09',1100),
						 (2015,'2023-12-11',9000),
						 (2016,'2023-11-01',5000),
						 (2016,'2023-12-01',2000),
						 (2017,'2024-01-19',4000),
						 (2018,'2019-11-09',8500);


insert into performance_reviews values (2000,'2023-11-01',9),
						 (2000,'2023-12-01',10),
						 (2001,'2024-01-19',5),
						 (2002,'2019-11-09',6),
						 (2003,'2023-12-11',4),
						 (2004,'2023-11-01',8),
						 (2004,'2023-12-01',9),
						 (2005,'2024-01-19',7),
						 (2006,'2019-11-09',8),
						 (2007,'2023-12-11',9),
						 (2008,'2023-11-01',10),
						 (2009,'2023-12-01',8),
						 (2009,'2024-01-19',6),
						 (2010,'2019-11-09',9),
						 (2010,'2019-11-09',8),
						 (2011,'2023-12-11',8),
						 (2012,'2023-11-01',4),
						 (2013,'2023-12-01',7),
						 (2014,'2024-01-19',9),
						 (2014,'2019-11-09',8),
						 (2015,'2023-12-11',8),
						 (2016,'2023-11-01',7),
						 (2016,'2023-12-01',6),
						 (2017,'2024-01-19',7),
						 (2018,'2019-11-09',6),
						 (2019,'2021-11-08',1);

select * from departments;
select * from employees;
select * from sales;
select * from performance_reviews;

----------RANK

Select e.employee_id ,e.name,d.department_name , sum(s.amount) as [total Sales amount],
RANK() over(partition by e.department_id order by sum(s.amount) desc) 
from employees as e 
join sales as s
on e.employee_id = s.employee_id 
join departments as d on e.department_id = d.department_id
group by e.employee_id, e.name,e.department_id, d.department_name ;

---------------DENSE_RANK

Select e.employee_id ,e.name,d.department_name , sum(s.amount) as [total Sales amount],avg(p.score) as 'average review',
DENSE_RANK() over(partition by e.department_id order by avg(p.score) desc) as RANKING
from employees as e 
join sales as s
on e.employee_id = s.employee_id 
join departments as d on e.department_id = d.department_id
JOIN performance_reviews as p on e.employee_id = p.employee_id
group by e.employee_id, e.name,e.department_id, d.department_name ;

---------------ROW_NUMBER

select * FROM(
Select e.employee_id ,e.name,d.department_name , sum(s.amount) as [total Sales amount],
ROW_NUMBER() over(partition by e.department_id order by sum(s.amount) desc) AS RANKING 
from employees as e 
join sales as s
on e.employee_id = s.employee_id 
join departments as d on e.department_id = d.department_id
group by e.employee_id, e.name, e.department_id, d.department_name)AS J WHERE RANKING<=3;

select * FROM(
Select e.employee_id ,e.name,d.department_name , sum(s.amount) as [total Sales amount],avg(p.score) as 'average review',
ROW_NUMBER() over(partition by e.department_id order by sum(s.amount) desc) AS RANKING 
from employees as e 
join sales as s
on e.employee_id = s.employee_id 
join departments as d on e.department_id = d.department_id
JOIN performance_reviews AS P ON e.employee_id = p.employee_id
group by e.employee_id, e.name, e.department_id, d.department_name)AS J WHERE RANKING=1 ORDER BY department_name , [total Sales amount] DESC;




