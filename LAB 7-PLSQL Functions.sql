LAB 7

after using delimiter ; wont work for normal cases also so 
use \g to get output

drop function if exists average; \g

1
delimiter //
create function multiply (a int, b int)
returns int
begin
declare prod int;
set prod=a*b;
return prod;
end;
//

select multiply(4,9);
\g

2
delimiter //
create function maximum(a int, b int)
returns int
begin
declare m int;
if a>b then set m=a;
else set m=b;
end if;
return m;
end;
//

select maximum(4,9);
\g

3
delimiter //
create function tot_books()
returns int
begin
declare tot int;
select count(*) into tot from books;
return tot;
end;
//

select tot_books();
\g

4
delimiter //
create function average(w int, x int, y int, z int)
returns float
begin
declare avgg float;
set avgg=(w+x+y+z)/4;
return avgg;
end;
//

select average(3,6,8,5);
\g

5
delimiter //
create function factorial(n int)
returns int
begin
declare fact int;
set fact=1;
while n > 0 do
set fact=n*fact;
set n=n-1;
end while;
return fact;
end;
//

select factorial(6); \g

6
delimiter //
create function cheap_book()
returns varchar(15)
begin 
declare libname varchar(15);
select lname into libname from books b 
inner join ilib i on i.lid=b.lid 
where b.price = (select min(price) from books);
return libname;
end;
//

select cheap_book() as "Library name with cheapest books";
\g

7
delimiter //
create function total_books()
returns int
begin
declare totalbooks int;
select count(*) into totalbooks from issue i 
inner join staff s on s.memid=i.memid 
inner join department d on d.deptid=s.deptid 
where d.Iname="SIT";
return totalbooks;
end;
//

select total_books();
\g

