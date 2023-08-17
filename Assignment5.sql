create database Assignment05Db
use Assignment05Db
-------------------------------------------
create schema bank
create table bank.Customer
(
	CId int primary key identity(1000,1),
	CName nvarchar(50) not null,
	CEmail nvarchar(50) not null unique,
	Contact nvarchar(50) not null unique,
	CPwd as right(CName,2)+cast(CId as nvarchar(10))+left(Contact,2) persisted 
)
insert into bank.Customer(CName,CEmail,Contact) values ('Dev','dev@gmail.com','9381225704')
insert into bank.Customer(CName,CEmail,Contact) values ('Janu','janu@gmail.com','9876787655')
insert into bank.Customer(CName,CEmail,Contact) values ('Diya','diya@gmail.com','9381225604')
insert into bank.Customer(CName,CEmail,Contact) values ('Vicky','vicky@gmail.com','9876787334')
insert into bank.Customer(CName,CEmail,Contact) values ('David','david@gmail.com','9876747654')
select * from bank.Customer

create table bank.MailInfo
(	
	MailTo nvarchar(50),
	MailDate date,
	MailMessage nvarchar(50)
)

create trigger InsertIntoCustomer
on bank.Customer
after insert
as
begin
declare @id int
declare @name nvarchar(50)
declare @mail nvarchar(50)
declare @contact nvarchar(50)
declare @pwd nvarchar(50)
declare @msg nvarchar(50)
select @id=Cid,@name=CName,@mail=CEmail,@contact=Contact,@pwd=(right(CName,2)+cast(CId as nvarchar(10))+left(Contact,2)) from inserted
select @msg='you NetBanking password is : '+@pwd+'it is valid up to 2 days only. Update it!!!!!!!'

insert into MailInfo values (@mail,GETDATE(),@msg)

if(@@ROWCOUNT>=1)
begin
print 'After trigger value inserted'
end
end

insert into bank.Customer(CName,CEmail,Contact) values ('Riya','riya@gmail.com','8008317426')
select * from bank.Customer
select * from bank.MailInfo