select min(pws.minimum_order),max(pws.maximum_order),count(pws.total_orders),sum(pws.total order_bill),
    avg(pws.total_order_bill)from (
     select
     productcode,
     count(ordernumber)"total_orders",
     sum(quantityordered *priceeach) "total_order_bill",
    min(quantityordered *priceeach) "minimum_order",
    max(quantityordered *priceeach) "maximum_order",
    avg (quantityordered *priceeach) "average_order"
	from orderdetails
	group by productcode)pws;
	
	
	#joints
	
	#display product code,productname and textdescription for all the productlines
	
	
	select productcode, productname,textdescription
	from products p inner join productlines pl on p.productline=p1.productline limit 2;
	
	select o.ordernumber,o.status,sum(od.quantityordered*od.priceeach) "total sales"
	from orders o inner join orderdetails od on o.ordernumber=od.ordernumber
	group by o.ordernumber;
	
	select od.ordernumber,od.quantityordered,od.priceeach,
	o.orderdate,p.productname,c.customername from orderdetails od inner join orders o using(ordernumber)
    inner join pro



select ordernumber,productname,msrp,priceeach from products p inner join orderdetails o on p.productcode = o.productcode and p.msrp > o. priceeach where 
p.productcode = 'S10_1678' and o.priceeach >84; 	
	
	select customername, c.customernumber,o.ordernumber from customer c left join orders o on c.customernumber=o.ordernumber where
	o.ordernumber is null;
	
	
select customername,e.firstname,p.checknumber,p.amount from customer c left join employee e on c.salesRepEmployeeNumber = e.employeenumber left join payments p1on c.customernumber=
p.customernumber	where e.employeenumber is null and p.checknumber is null;

select b.employeenumber,concat(b.lastname,b.firstname) as "employee name",
concat(a.lastname,a.firstname) "Manager"
from employees a inner join employees b on a.employeenumber= b.reportsTo;

 (1,'hearts')
 (2,'diamond')
 (3,'club')
 (4,'spade')
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 /#subquries/
 
 select concat(firstname," ",lastname) "employees" from employees
 where offficecode in (
 select officecode from offfices where country 'USA')
 
 
 
 select customername from customers
 where customernumber in (
 select customernumber from payments
 where amount > (select avg(amount) from payments));
 
 select customername from customers
 where customernumber = (
 select customernumber from payments
 where amount = (select max(amount) from payments));
 
 
 select customername country,state from customers where (country,state) in
 (
 select country,state from offices where country='usa');
 
  select customername country,state from customers where (country,state) not in
 (
 select country,state from offices where country='usa');
 
 
 select ordernumber, productcode from orderdetails od where exists (
 select 1 from products p where p.productcode =od.productcode);
 
 
 #store procedure
 
 Delimiter //
 create procedure getAllcustomers()
 begin
   select * from customers;
 end //
 delimiter ;  
 
 call getAllcustomers();
 
 
 drop procedure if exists getAllcustomers;
 
 Delimiter //
 create procedure getAllcustomers (
       in countryname varchar(50),
	   in statename varchar (50)
	   )
 begin
       select * from customers where
	   country = countryname and state = statename;
 end //

Delimiter ; 


Delimiter //
create procedure getallcustomercountbycountry(
    in countryname varchar(50),
	out totalcustomercount int
	)
	
begin
     select count(customernumber) into totalcustomercount
	 from customers where country = countryname;

end //
Delimiter ;

call getallcustomercountbycountry('japan',@total);
select @total;


Delimiter $$
create procedure setcounter(
inout counter int,
in inc int
)

begin 
    set counter = counter+inc;
end $$
Delimiter ;

set @counter=0;
select @counter;
call setcounter(@counter,3);
select @counter;


Delimiter //
create procedure getCustomerlevel(
in pcustnumber int,
out pcustlevel varchar(30),
out pcustname varchar(100)
)
begin 
 declare credit decimal default 0;
 select creditlimit, customername into credit,pcustname from
customers where customernumber= pcustnumber;
if credit > 50000 then 
       set pcustlevel = 'platinum';
elseif credit <=50000 and credit >10000 then
       set pcustlevel = 'Gold';
else  
       set pcustlevel = 'silver';
end if;
end //
Delimiter ;

Delimiter //
create procedure orderscountdss(
in startdate date,
in enddate date,
out ordercount int,
out qcount int
) 
begin
select  count(distinct o.ordernumber),sum(od.quantityordered*priceeach) into ordercount,qcount  from orders o inner join orderdetails od on  o.ordernumber= od.ordernumber where orderdate between startdate and enddate;
end //
Delimiter ;


delimiter ##
create procedure broadcastlist(
           inout email_list textdescription
		   )
		   begin
		   
		   
		   
		   CREATE TABLE EMP(
    empno INT PRIMARY KEY,
    ename VARCHAR(50),
    job VARCHAR(50),
    mgr INT,
    hiredate DATE,
    sal DECIMAL(10, 2),
    comm DECIMAL(10, 2),
    deptno INT
);

INSERT INTO EMP (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES
(8369, 'SMITH', 'CLERK', 8902, '1990-12-18', 800.00, NULL, 20),
(8499, 'ANYA', 'SALESMAN', 8698, '1991-02-20', 1600.00, 300.00, 30),
(8521, 'SETH', 'SALESMAN', 8698, '1991-02-22', 1250.00, 500.00, 30),
(8566, 'MAHADEVAN', 'MANAGER', 8839, '1991-04-02', 2985.00, NULL, 20),
(8654, 'MOMIN', 'SALESMAN', 8698, '1991-09-28', 1250.00, 1400.00, 30),
(8698, 'BINA', 'MANAGER', 8839, '1991-05-01', 2850.00, NULL, 30),
(8882, 'SHIVANSH', 'MANAGER', 8839, '1991-06-09', 2450.00, NULL, 10),
(8888, 'SCOTT', 'ANALYST', 8566, '1992-12-09', 3000.00, NULL, 20),
(8839, 'AMIR', 'PRESIDENT', NULL, '1991-11-18', 5000.00, NULL, 10),
(8844, 'KULDEEP', 'SALESMAN', 8698, '1991-09-08', 1500.00, 0.00, 30);


mysql> use  classicmodels;
Database changed
mysql> CREATE TABLE empl(
    ->     empno INT PRIMARY KEY,
    ->     ename VARCHAR(50),
    ->     job VARCHAR(50),
    ->     mgr INT,
    ->     hiredate DATE,
    ->     sal DECIMAL(10, 2),
    ->     comm DECIMAL(10, 2),
    ->     deptno INT
    -> );
Query OK, 0 rows affected (0.65 sec)

mysql> INSERT INTO empl (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES
    -> (8369, 'SMITH', 'CLERK', 8902, '1990-12-18', 800.00, NULL, 20),
    -> (8499, 'ANYA', 'SALESMAN', 8698, '1991-02-20', 1600.00, 300.00, 30),
    -> (8521, 'SETH', 'SALESMAN', 8698, '1991-02-22', 1250.00, 500.00, 30),
    -> (8566, 'MAHADEVAN', 'MANAGER', 8839, '1991-04-02', 2985.00, NULL, 20),
    -> (8654, 'MOMIN', 'SALESMAN', 8698, '1991-09-28', 1250.00, 1400.00, 30),
    -> (8698, 'BINA', 'MANAGER', 8839, '1991-05-01', 2850.00, NULL, 30),
    -> (8882, 'SHIVANSH', 'MANAGER', 8839, '1991-06-09', 2450.00, NULL, 10),
    -> (8888, 'SCOTT', 'ANALYST', 8566, '1992-12-09', 3000.00, NULL, 20),
    -> (8839, 'AMIR', 'PRESIDENT', NULL, '1991-11-18', 5000.00, NULL, 10),
    -> (8844, 'KULDEEP', 'SALESMAN', 8698, '1991-09-08', 1500.00, 0.00, 30);
Query OK, 10 rows affected (0.09 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> select ename,sal from empl where sal>=2200;
+-----------+---------+
| ename     | sal     |
+-----------+---------+
| MAHADEVAN | 2985.00 |
| BINA      | 2850.00 |
| AMIR      | 5000.00 |
| SHIVANSH  | 2450.00 |
| SCOTT     | 3000.00 |
+-----------+---------+
5 rows in set (0.00 sec)

mysql> select * from emp1 where comm is null;
ERROR 1146 (42S02): Table 'classicmodels.emp1' doesn't exist
mysql> select * from empl where comm is null;
+-------+-----------+-----------+------+------------+---------+------+--------+
| empno | ename     | job       | mgr  | hiredate   | sal     | comm | deptno |
+-------+-----------+-----------+------+------------+---------+------+--------+
|  8369 | SMITH     | CLERK     | 8902 | 1990-12-18 |  800.00 | NULL |     20 |
|  8566 | MAHADEVAN | MANAGER   | 8839 | 1991-04-02 | 2985.00 | NULL |     20 |
|  8698 | BINA      | MANAGER   | 8839 | 1991-05-01 | 2850.00 | NULL |     30 |
|  8839 | AMIR      | PRESIDENT | NULL | 1991-11-18 | 5000.00 | NULL |     10 |
|  8882 | SHIVANSH  | MANAGER   | 8839 | 1991-06-09 | 2450.00 | NULL |     10 |
|  8888 | SCOTT     | ANALYST   | 8566 | 1992-12-09 | 3000.00 | NULL |     20 |
+-------+-----------+-----------+------+------------+---------+------+--------+
6 rows in set (0.00 sec)

mysql> select e_name,sal from emp1 where sal<2500 or sal>4000;
ERROR 1146 (42S02): Table 'classicmodels.emp1' doesn't exist
mysql> select e_name,sal from empl where sal<2500 or sal>4000;
ERROR 1054 (42S22): Unknown column 'e_name' in 'field list'
mysql> select ename,sal from empl where sal<2500 or sal>4000;
+----------+---------+
| ename    | sal     |
+----------+---------+
| SMITH    |  800.00 |
| ANYA     | 1600.00 |
| SETH     | 1250.00 |
| MOMIN    | 1250.00 |
| AMIR     | 5000.00 |
| KULDEEP  | 1500.00 |
| SHIVANSH | 2450.00 |
+----------+---------+
7 rows in set (0.00 sec)

mysql> select ename,sal from empl where sal<2500 or sal>4000 order by sal;
+----------+---------+
| ename    | sal     |
+----------+---------+
| SMITH    |  800.00 |
| SETH     | 1250.00 |
| MOMIN    | 1250.00 |
| KULDEEP  | 1500.00 |
| ANYA     | 1600.00 |
| SHIVANSH | 2450.00 |
| AMIR     | 5000.00 |
+----------+---------+
7 rows in set (0.00 sec)

mysql> select ename,job,sal from empl where mgr is null;
+-------+-----------+---------+
| ename | job       | sal     |
+-------+-----------+---------+
| AMIR  | PRESIDENT | 5000.00 |
+-------+-----------+---------+
1 row in set (0.00 sec)

mysql>
mysql> select ename from emp1 where ename like '__a%';
ERROR 1146 (42S02): Table 'classicmodels.emp1' doesn't exist
mysql> select ename from empl where ename like '__a%';
Empty set (0.00 sec)

mysql> select ename from emp1 where ename like '%t';
ERROR 1146 (42S02): Table 'classicmodels.emp1' doesn't exist
mysql> select ename from empl where ename like '%t';
+-------+
| ename |
+-------+
| SCOTT |
+-------+
1 row in set (0.00 sec)

mysql> select ename from empl where ename like 'm_l%';
Empty set (0.00 sec)

mysql>
mysql> ^C
mysql> select ifnull(com,'null','notgiven') as comm form empl;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'form empl' at line 1
mysql> select ifnull(com,'null','notgiven') as comm from empl;
ERROR 1582 (42000): Incorrect parameter count in the call to native function 'ifnull'
mysql> select ifnull(comm,'notgiven') as comm from empl;
+----------+
| comm     |
+----------+
| notgiven |
| 300.00   |
| 500.00   |
| notgiven |
| 1400.00  |
| notgiven |
| notgiven |
| 0.00     |
| notgiven |
| notgiven |
+----------+
10 rows in set (0.00 sec)

 
		   

	
	

	   
	   
 
 

	