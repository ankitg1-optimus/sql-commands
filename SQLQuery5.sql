create database practice;
use practice;
create table orders(orderID int identity(1,1) primary key, customerName varchar(255), customerCity varchar(255), price int, orderDate date DEFAULT GETDATE());
insert Into orders(customerName, customerCity, price) values ('Johson', 'Fransico', 10297),
('Emily','Paris', 9021),('Alice','Mosco',5337),('Lisa','Paris',7599);
select * from orders;
Truncate table orders;
insert Into orders(customerName, customerCity, price) values ('Andrea', 'Xiang', 29714);
Delete from orders where orderID in (1,2,3,4,5);

insert Into orders(customerName, customerCity, price) values ('Ruru', 'Wokha', 17733);
Delete from orders where orderID = 12;
Select Count(customerName)as [number of orders],customerCity from orders group by customerCity having customerCity in ('paris', 'mosco');