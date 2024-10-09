BACKUP DATABASE STUDENTDB
TO DISK = '\\CPC-ankit-T45IM\Users\ankit.gwari\OneDrive - Optimus Information Inc\Desktop';
use StudentDB;
CREATE TABLE Persons (
    Id int PRIMARY KEY,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int
);

Select * from Persons;
insert into persons(id, lastname, firstname, age) values (9,'sanzo','hanabi', 28);
--foreign Key
CREATE TABLE Orders (
    OrderID int NOT NULL PRIMARY KEY identity(1,1),
    OrderNumber int NOT NULL,
    PersonID int FOREIGN KEY REFERENCES Persons(Id)
);
--check
Alter table persons add constraint verifyingAge check (age>=18);
Insert into persons(id, lastname, firstname, age) values (2,'singh','alucard', 32);
--default
Alter table persons add city varchar(255) default 'noida';
--dates
alter table persons add entryDate date DEFAULT GETDATE(); 
Insert into persons(id, lastname, firstname, age) values (8,'kumari','Angelena', 22);
Delete from persons where ID in(2, 9, 7);
--views
create view todaysEntries as
select * 
from persons 
where entryDate = GETDATE();
drop view todaysEntries;
select * from todaysEntries;

