create procedure specificcode3
(@codeIs varchar(255))
as
if @codeIs is null
select *from items
order by code
else 
select *from items
where code=@codeIs
go

EXEC specificcode3 @codeIs =NULL 



--q2
create procedure getOrder @status1 varchar(255),@date1 date,@orderno int
as
select e.date,
i.TotAmount,
i.UnitDesc,
quant,
e.status
from exOrders e join Invoices i
on e.orderNo=i.orderNo
where e.date=@date1 or e.status=@status1 or e.orderNo=@orderno

go

EXEC getOrder @status1=null ,@date1=null ,@orderno=2002

--q3
create procedure getCustumerData1 @custIdIs int
as
select c.CustID,
CustName,
Status,
orderNo,
CustStatus,
code,
quant,
Freq
from Customers c join Subscription s 
on c.CustID=s.CustID
where c.CustID=@custIdIs
go



EXEC getCustumerData1 @custIdIs=1

--q4
create procedure gettotal @dateis date
as
select
orderNo,
RecNo,
Date,
Amount,
case when CrdtDebt='Credit' then amount  else null end as Income ,
case when CrdtDebt='Debit' then amount  else null end as Expense

from Accounting 
where Date>=@dateis(select
sum(case when CrdtDebt='Credit' then amount  else 0 end )as TotalIncome ,
SUM(case when CrdtDebt='Debit' then amount  else 0 end )as TotalExpense,
sum(case when CrdtDebt='Credit' then amount  else 0 end )-SUM(case when CrdtDebt='Debit' then amount  else 0 end ) as balance


from Accounting
)
go
exec gettotal  @dateis='2024-08-03'
--q5
create procedure getorders3 
as 
select
e.date,
e.suppDate,
i.TotAmount,
status
from exOrders e join Invoices i
on e.orderNo=i.orderNo
where status in ('Not Shipped','Reserved In Progress')
order by e.suppDate
go

exec getorders3
