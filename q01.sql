create database assessment;
use assessment;

create table t_product_master(
	Product_ID varchar(255) PRIMARY KEY,
	Product_Name varchar(255),
	Cost_Per_Item int
)
create table t_user_master(
	User_ID varchar(255) PRIMARY KEY,
	User_Name varchar(255)
)
create table t_transaction(
    User_ID varchar(255) FOREIGN KEY REFERENCES t_user_master(USER_ID) ,
	Product_ID varchar(255) FOREIGN KEY REFERENCES t_product_master(Product_ID),
	Transaction_Date date,
	Transaction_Type varchar(255),
	Transaction_Amount int
)

Insert into t_product_master values ('P1', 'Pen', 10),
									('P2', 'Scale', 15),
									('P3', 'NoteBook', 25);

Insert into t_user_master values ('U1', 'Alfred Lawrence'),
									('U2', 'William Paul'),
									('U3', 'Edward Fillip');

Insert into t_transaction values ('U1','P1', '2010-10-25', 'Order', 150),
								('U1','P1', '2010-11-20', 'Payment', 750),
								('U1','P1', '2010-11-20', 'Order', 200),
								('U1','P3', '2010-11-25', 'Order', 50),
								('U3','P2', '2010-10-26', 'Order', 100),
								('U2','P1', '2010-12-15', 'Order', 75),
								('U3','P2', '2011-01-15', 'Payment', 250);



Select u.User_Name, 
p.Product_Name, 
	Sum(case 
		when t.Transaction_Type ='Order' then t.Transaction_Amount
		else 0
	end) as [ordered_quantity],
	sum(case 
		when t.Transaction_Type ='Payment' then t.Transaction_Amount
		else 0
	end)as [amount_paid],
	Max(t.Transaction_Date) as [Last transaction Date],
	(Sum
		(case
			when t.Transaction_Type='order' then t.Transaction_Amount
			else 0
		end)*p.Cost_Per_Item 
		-
	sum
		(case 
			when t.Transaction_Type='payment' then t.Transaction_Amount
			else 0
		end))
	as Balance
from t_user_master as u 
join t_transaction as t on t.User_ID =u.User_ID
join t_product_master as p on t.Product_ID = p.Product_ID 
group by u.User_Name,p.Product_Name, p.Cost_Per_Item order by User_Name;

