use StudentDB;
--see table
Select * from Student;
--update query
UPDATE Student set ADDRESS = 'Gurgaon'
where ADDRESS = 'Haryana';
Update student set roll_no = 76 where roll_no = 87; 
--delete query
DELETE Student where ROLL_NO = 9;
--select top few records(number or percent) only
SELECT TOP 3 * FROM Student;
SELECT TOP 60 percent * FROM Student;
--adding marks coulmn
ALTER table student add marks int;
--adding marks 
update student set marks = 90
where roll_no = 10;
update student set marks = 30
where roll_no = 12;
update student set marks = 85
where roll_no = 25;
update student set marks = 52
where roll_no = 30;
update student set marks = 53
where roll_no = 76;
update student set marks = 35
where roll_no = 81;
--aggregate functions
select count(*) as [Number of Student], ADDRESS 
from Student group by ADDRESS; 
select min(marks) from Student;
select max(marks) from Student;
SELECT SUM(marks)/count(*) as [Avg marks] 
FROM Student;
SELECT AVG(marks) as [Avg marks] 
FROM Student;
Select Count(*) as [Passed student] from student where marks>33;
--like
SELECT * FROM Student
WHERE NAME LIKE '[a-f]%';
SELECT * FROM Student
WHERE NAME LIKE '[bjt]%';
--in
SELECT * FROM Student
WHERE ADDRESS IN ('Pune', 'dehradun');
--in
SELECT * From student where marks between 50 and 80;
SELECT * From student where marks not between 50 and 80;

select name as Indians from Student  where phone like '9%';