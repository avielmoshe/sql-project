
create table items (
code varchar(255) not null primary key,
[desc] varchar(255) ,
unitprice int ,
available int,
saved int,
waiting int,
subscript int ,
freq varchar(255),
suppdate date,
orderPercnt decimal(5,2)
)

select *
from items
INSERT INTO Items 
VALUES
    ('101', 'Office Chair', 100, 50, 10, 5, 20, 30, '2024-08-01', 10),
    ('102', 'Desk Lamp', 200, 30, 15, 10, 25, 40, '2024-08-05', 15),
    ('103', 'Monitor Stand', 150, 20, 5, 2, 10, 20, '2024-08-10', 20),
    ('104', 'Ergonomic Keyboard', 250, 40, 20, 8, 30, 25, '2024-08-15', 25),
    ('105', 'Wireless Mouse', 180, 60, 30, 12, 15, 35, '2024-08-20', 18);

create table Discounts (
CustType varchar(255)not null primary key,
Discnt decimal(5,2),
);

insert into Discounts
values ('1',10)
insert into Discounts
values ('2',25)

delete from Discounts


create table Customers(
CustID int not null primary key,
CustType varchar(255)  FOREIGN KEY REFERENCES discounts(custtype),
CustStatus varchar(255),
FreezCode varchar(255) ,
OverCount int,
CustName varchar(255) ,
[DelivAddrss]varchar(255),
MailAddrss varchar(255),
CreditCard int,



);



INSERT INTO Customers 
VALUES
    (1, '1', 'ACT', 'None', 0, 'John Doe', '123 Main St, Springfield', 'john.doe@example.com', 12347890),
    (2, '2', 'FRZ', '1', 2, 'Jane Smith', '456 Elm St, Springfield', 'jane.smith@example.com', 23458901),
    (3, '1', 'DEL', 'None', 0, 'Alice Johnson', '789 Oak St, Springfield', NULL, 34789012),
    (4, '2', 'ACT', '2', 1, 'Bob Brown', '101 Pine St, Springfield', 'bob.brown@example.com', 45789123),
    (5, '1', 'FRZ', '1', 0, 'Charlie White', '202 Cedar St, Springfield', 'charlie.white@example.com', 5681234);
select *
from Customers

create table deliveryFee(
Delivery varchar(255)not null primary key,
Desc decimal(5,2),
);
insert into deliveryFee
values
('1','slow',20),
('3','fast',100),
('2','normal',50)

select *
from deliveryFee

create table exOrders(
orderNo int not null primary key,
[date] date,
CustID int FOREIGN KEY REFERENCES Customers(CustID),
code varchar(255) FOREIGN KEY REFERENCES items(code),
quant int,
delivery varchar(255)  FOREIGN KEY REFERENCES deliveryFee(delivery),
[address] varchar(255),
[status] varchar(255),
suppDate date,



);
select *
from exOrders

insert into exOrders (OrderNo, [date], CustID, Code, quant, delivery, [address], [status], suppDate)
values
(2001, '2024-08-01', 1, '101', 2, '1', '123 Main St Springfield', 'Open', '2024-08-01'),
    (2002, '2024-08-05', 2, '102', 1, '2', '456 Elm St Springfield', 'In Progress', '2024-08-05'),
    (2003, '2024-08-10', 3, '103', 5, '3', '789 Oak St Springfield', 'Closed', '2024-08-10'),
    (2004, '2024-08-15', 4, '104', 3, '1', '101 Pine St Springfield', 'Reserved In Progress', '2024-08-15'),
    (2005, '2024-08-20', 5, '105', 4, '3', '202 Cedar St Springfield', 'Not Shipped', '2024-08-20');

	select *
from exOrders 



create table Profiles (
Profile varchar(255)not null primary key,
Act int,
);
INSERT INTO Profiles
VALUES 
    ('Office', '10 times per day'),
    ('Sales', 'Full access'),
    ('Support', 'Read-only'),
    ('Management', 'Unlimited access');
	select *
	from Profiles




create table Users (
UserName varchar(255)not null primary key,
Profile varchar(255) FOREIGN KEY REFERENCES Profiles(Profile)
);

insert into Users
values ('aviel moshe','Management'),
('maor shmueli','Sales')






select *
from Profiles



create table Numbers(
LastOrder int,
LastSubsc int,
LastStock int,
LastReciept int,
LastInvoice int,



);

insert into Numbers
values(2005,1000,50,5005,3005)





create table Subscription(
orderNo int FOREIGN KEY REFERENCES exOrders(orderNo),
CustID int FOREIGN KEY REFERENCES Customers(CustID),
code varchar(255) FOREIGN KEY REFERENCES items(code),
quant int,
delivery varchar(255)  FOREIGN KEY REFERENCES deliveryFee(delivery),
Freq varchar(255),
NextOrder date,
Expiration date,
[Status] varchar(255)


);

INSERT INTO Subscription ( OrderNo, CustID, Code, [Status], quant, Freq, Delivery, NextOrder, Expiration)
VALUES
    (2001, 1, '101', 'Active', 2, 'Monthly', '1', '2024-09-01', '2025-08-01'),
    ( 2002, 2,'102', 'Active', 1, 'Quarterly', '2', '2024-11-05', '2025-11-05'),
    ( 2003, 3, '103', 'Expired', 5, 'Annually', '3', '2024-08-10', '2024-08-10'),
    ( 2004, 4, '104', 'Active', 3, 'Bi-Weekly', '1', '2024-08-16', '2025-08-16'),
    (2005, 5, '105', 'Pending', 4, 'Monthly', '2', '2024-09-20', '2025-09-20');

	select *
	from Subscription

create table Invoices(
orderNo int FOREIGN KEY REFERENCES exOrders(orderNo),
UnitDesc varchar(255),
UnitPrice int,
NoUnits int,
InvNo int primary key,
TotAmount int,
[Date] date,



);




INSERT INTO Invoices (InvNo, OrderNo, [Date], UnitDesc, NoUnits, UnitPrice, TotAmount)
VALUES
    (3001, 2001, '2024-08-02', 'Office Chair', 2, 100, 200),
    (3002, 2002, '2024-08-06', 'Desk Lamp', 1, 200, 200),
    (3003, 2003, '2024-08-11', 'Monitor Stand', 5, 150, 750),
    (3004, 2004, '2024-08-16', 'Ergonomic Keyboard', 3, 250, 750),
    (3005, 2005, '2024-08-21', 'Wireless Mouse', 4, 180, 720);

create table StockOrder(
orderNo int FOREIGN KEY REFERENCES exOrders(orderNo),
code varchar(255) FOREIGN KEY REFERENCES items(code),
Descr varchar(255),
Quant int,
StockDate date,



);

INSERT INTO StockOrder (OrderNo, StockDate, Code, [Descr], Quant)
VALUES
    (2001, '2024-08-01', '101', 'Initial stock order for new office chairs', 100),
    (2002, '2024-08-05', '102', 'Order of desk lamps for the new office', 50),
    (2003, '2024-08-10', '103', 'Replenishment of monitor stands', 30),
    (2004, '2024-08-15', '104', 'Order of ergonomic keyboards', 40),
    (2005, '2024-08-20', '105', 'Stock up on wireless mice', 60);

	select *
	from StockOrder



create table Receipt(
orderNo int FOREIGN KEY REFERENCES exOrders(orderNo),
InvNo int  FOREIGN KEY REFERENCES Invoices(InvNo),

RecNo int primary key,
PaidAmt int,
PymtDate date,



);

INSERT INTO Receipt (RecNo, PymtDate, InvNo, OrderNo, PaidAmt)
VALUES
    (5001, '2024-08-02', 3001, 2001, 200),
    (5002, '2024-08-06', 3002, 2002, 200),
    (5003, '2024-08-11', 3003, 2003, 750),
    (5004, '2024-08-16', 3004, 2004, 750),
    (5005, '2024-08-21', 3005, 2005, 720);

create table Accounting(
orderNo int FOREIGN KEY REFERENCES exOrders(orderNo),
InvNo int  FOREIGN KEY REFERENCES Invoices(InvNo),
RecNo int FOREIGN KEY REFERENCES Receipt(RecNo),
CrdtDebt varchar(255),
Amount int,
[Date] date,



);
INSERT INTO Accounting (RecNo, Amount, CrdtDebt, InvNo, OrderNo, [Date])
VALUES
    (5001, 200, 'Credit', 3001, 2001, '2024-08-03'),
    (5002, 200, 'Credit', 3002, 2002, '2024-08-07'),
    (5003, 750, 'Credit', 3003, 2003, '2024-08-12'),
    (5004, 750, 'Credit', 3004, 2004, '2024-08-17'),
    (5005, 720, 'Debit', 3005, 2005, '2024-08-22');