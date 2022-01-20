LAB 8

1
delimiter //
create procedure book_details(in libname varchar(20))
begin
select * from books b inner join ilib i on i.lid=b.lid and i.lname=libname;
end;
//

call book_details("SITLib");
\g

2
delimiter //
create procedure author(in aut_name varchar(20))
begin
select count(*) from author a 
inner join writes w where a.Aid=w.Aid 
and a.aname=aut_name;
end;
//

call author("Shruti"); \g

3
set autocommit=0;

delimiter //
create procedure update_price(in sellername varchar(20), in libname varchar(20))
begin
update books set price = price + (price * 0.1) 
where lid in (select lid from purchase 
where sid in (select sid from seller where slname=sellername) 
and lid in (select lid from ilib where lname=libname));
end;
//


call update_price('ABP','SIBMLib');

4
delimiter //
create procedure tot_publisher(in libname varchar(20))
begin
select count(*) from purchase where lid in 
(select lid from ilib where lname=libname);
end;
//

call tot_publisher("SITLib"); \g

5
delimiter //
create procedure MinMaxBookPrice(in libname varchar(20))
begin
select bname as "Cheapest Book" , price from books 
where price = 
(select min(price)  from books 
where lid in 
(select lid from ilib where lname=libname));

select bname "Costliest Book" , price from books 
where price = 
(select max(price) from books 
where lid in 
(select lid from ilib where lname=libname));
end;
//

 call MinMaxBookPrice("SITLib"); \g

6
set autocommit=0;

delimiter //
create procedure update_price2(in authorname varchar(20))
begin
update books set price = price + (price * 0.25) 
where bid in (select bid from writes 
where Aid in (select Aid from author where aname=authorname));
end;
//


call update_price2("Shruti");

7
delimiter //
create procedure expense(in libname varchar(20), in monthno int)
begin
select sum(totalcost) from purchase 
where month(date)=monthno and lid in 
(select lid from ilib where lname=libname);
end;
//

call expense("SITLib",07); \g

