create table location (
address varchar(50), StateCharges int );
select * from location ;

Insert into location values('dehradun', 50000),('pune', 60000),('kerala',45000),('kolkata',55000),('delhi',10000);
--join
Select student.roll_no, student.name, student.phone, student.ADDRESS, location.StateCharges as Domicile   From student 
FULL OUTER JOIN location ON
student.address = location.address
where student.ADDRESS is not null;

insert into student values(6,'Albert','Pune','1231111145',23,40);
--group by and having
SELECT count(name)as [no of students],ADDRESS
FROM Student
GROUP BY ADDRESS having count(name)>1 ORDER BY ADDRESS ;
--exists
Select Name as [Eligible Students]
from Student 
where exists (select name from student where ADDRESS = 'mumbai');
--any,all
--select into
	Select * into NorthIndia from Student where address in('dehradun','delhi','gurgaon');
	select * from NorthIndia
--insert into select
	Insert into NorthIndia select * from student where address is null;
--case
SELECT *,
CASE
    WHEN marks > 30 THEN 'You have passed'
    ELSE 'You failed'
END AS Result
FROM student;
--procedures
Create procedure showAllStudents 
as 
SELECT * From student;
GO
EXEC showAllStudents;

Create Procedure showPassedStudents @passingMarks int
as 
begin
Select * from student where marks > @passingMarks;
end
GO

Exec showPassedStudents @passingMarks = 33;
