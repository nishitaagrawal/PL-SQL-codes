LAB 9

1
set autocommit=0;

create table books_log(tid int auto_increment, bid int not null, 
bname varchar(25) not null, price float not null, lid int not null, 
action varchar(20) not null ,changed_on datetime, primary key(tid));

delimiter //
create trigger books_update
after update on books
for each row
begin
insert into books_log set action="update", bid=old.bid, 
bname=old.bname, price=old.price, lid=old.lid, changed_on=now();
end //

update books set price=500 where bid=1; \g

select * from books_log;

show triggers;


2
create table booksby(tid int primary key auto_increment, 
bid int not null, bname varchar(25) not null, 
price float not null, lid int not null);

delimiter //
create trigger books_insert
before insert on books 
for each row
begin
insert into booksby(bid,bname,price, lid)
values(new.bid, new.bname, new.price,new.lid);
end //

insert into books(bid,bname,price, lid)
values(29,"Percy Jackson", 6000,1);  \g

select * from booksby;

show triggers;

3
create table purchase_log(tid int auto_increment primary key, 
prid int not null, lid int not null, Pid int not null, Sid int not null, 
bid int not null, old_quantity int not null, new_quantity int not null, 
date datetime, totalcost int not null, changed_on datetime, 
action varchar(20) not null);

delimiter //
create trigger purchase_update
after update on purchase 
for each row
begin
insert into purchase_log set action="update", prid=old.prid, 
lid=old.lid, Pid=old.Pid, Sid=old.Sid, bid=old.bid, 
old_quantity=old.quantity, new_quantity=new.quantity, 
date=old.date, changed_on=now(), totalcost=old.totalcost;
end
//


update purchase set quantity=200 where lid=3;

select * from purchase_log

show triggers;










