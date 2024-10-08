CREATE DATABASE StudentDB;
use StudentDB;
CREATE TABLE Student (
    ROLL_NO INT PRIMARY KEY,
    NAME VARCHAR(50),
    ADDRESS VARCHAR(100),
    PHONE VARCHAR(15),
    AGE INT
);
Insert into student values(87, 'Rito Riba', 'Delhi', '9999123444', 26 );
Insert into student values(25, 'Jasmine', 'Gurgaon', '9999321444', 21 );
Insert into student values(30, 'Julie', 'Dehradun', '9999123544', 25 );
Insert into student values(12, 'Becky', 'Pune', '1111123544', 26 );
Insert into student values(9, 'Alex', 'Kolkata', '9922223334', 22 );
Insert into student values(10, 'Alex', 'Kerala', '9922223241', 23 );
--entry without address
Insert into student( ROLL_NO ,NAME, PHONE, AGE) values(81, 'Tarun', '9944223241', 21 ); 
Select * from Student where name LIKE 'j%';
Select * from Student Order by age ;
SELECT DISTINCT(AGE),name  FROM Student  ;
Select * from Student where name LIKE 'j%' AND ADDRESS like 'd%';
Select * from Student where name LIKE 'j%' OR ADDRESS like 'd%';
Select * from Student where not name like 'a%';
Select * from Student where address not in ('Delhi','pune');
select * from Student;
Select* from Student where ADDRESS is not NULL;