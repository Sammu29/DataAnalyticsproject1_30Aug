create table employees (
	emp_id int primary key,
	name varchar(50),
	age integer,
	dept varchar(50),
	salary decimal(10,2),
	hire_date date
	);

insert into employees (EMP_id, name, age, dept, salary, hire_date)
Values
     (1, 'Alice', 20, 'HR', 10000, '2022-05-13'),
    (2, 'Steve', 20, 'Finance', 10000, '2022-05-13'),
    (3, 'Bob', 35, 'IT', 20000, '2022-05-11'),
    (4, 'Charlie', 28, 'Marketing', 50000, '2022-06-01'),
    (5, 'David', 40, 'HR', 70000, '2022-06-15'),
    (6, 'Eva', 25, 'Finance', 12000, '2022-07-01'),
    (7, 'Frank', 32, 'IT', 25000, '2022-07-10'),
    (8, 'Grace', 22, 'Marketing', 45000, '2022-08-01'),
    (9, 'Hank', 29, 'Sales', 30000, '2022-08-15'),
    (10, 'Ivy', 33, 'Sales', 35000, '2022-09-01'),
	(11, 'Abhi', 35, 'Games', 55000, '2022-09-09');

	truncate table employees

-- Querying the Data

select * from employees order by 1 asc;

select * from employees where dept = 'Marketing';
select * from employees where dept <>'Marketing';

--using alias name

select 
     emp_id,
	 name as emp_name
from employees;

-- arithmetic expressions in qurey

select 
     emp_id,
	 name,
	 salary,
	 salary * 12 as annual_salary
from employees; 

--q: retrive employees name, their monthly salary, and a 10% bonus of the salary.

select 
  	 name,
	 salary as monthly_salary,
	 salary * 0.10 as bonus
from employees;

--filter the data with where clause

--q retrieve employees in it dept with a salary grater than 20000.

select * from employees where dept = 'it' and salary > 20000;

--q retrieve employees in it dept or salary grater than 20000.

select * from employees where dept = 'it' or salary > 20000;

--q: salary between 30000 and 60000

select * from employees where salary between 30000 and 60000;

--unsing 'in' in where condition

select * from employees where dept in ('it','marketing');

select * from employees where dept not in ('it','marketing');


--using like 

--%<letter> ending of the word
--%<letter>% anywhere of the word
--<letter>% starting of the word

select
     name,
	 dept,
	 salary
from employees
where name like '%r';

--not like

select
     name,
	 dept,
	 salary
from employees

where name not like '%c'

-- SOrting data

select * from employees
order by emp_id asc;

select * from employees
order by emp_id desc;

-- sorting with multiple columns

select * from employees
order by dept asc, salary desc;

select * from employees
order by emp_id asc, age asc, dept desc, salary asc;

create table dept (
  dept_id int primary key,
  dept_name varchar(50)
  );

  insert into dept (dept_id, dept_name)
  values
  (1,'HR'),
  (2,'Finance'),
  (3,'IT'),
  (4,'Marketing'),
  (5,'Sales'),
  (6,'Operations'),
  (7,'Legal'),
  (8,'Support'),
  (9,'Engineering'),
  (10,'Research');

select * from dept;

-- joins

-- 1) inner joins: returns only rows where there is a match in both tables

--select * from <table_1>
--inner join <table_2> ON table_2.col = table_1.col

select * from employees
inner join dept on dept.dept_name = employees.dept
order by emp_id;

--USning alias name as on the same

select * from employees a
inner join dept b on b.dept_name = a.dept
order by emp_id;

--left join
select * from employees
left join dept on dept.dept_name = employees.dept
order by emp_id;

--right join 
select * from employees
right join dept on dept.dept_name = employees.dept
order by emp_id;


select * from employees
full outer join dept on dept.dept_name = employees.dept
order by emp_id;


-- aggregating and grouping
-- count, sum, aveerage, max, min

 select * from employees;

 select count(*) from employees;

 select count (dept) from employees;

  select count (distinct dept) from employees; 
  
  select * from dept;
  
  select distinct dept from dept;

  select count (*) from dept;

  select 
  sum (salary) as total_salary
  from employees;

  select 
  avg (salary) as avg_salary
  from employees;
  
  select 
   round(avg(salary),2) as avg_salary
  from employees;

  select 
    max (age) as max_age
	from employees;

  select
  min (salary) as min_salary
  from employees;

  --group by 

  select 
      dept, count (name)
  from employees
  group by dept;
  
 select
    Hire_date,count(name)
  from employees
  group by hire_date
  order by hire_date;

      select 
        dept,
		age,
       round  (avg (salary), 2) as avg_salary
	 from employees
	 where age >= 25
	 group by dept,age;
	
select 
    dept,
	hire_date,
	count(*)
    from employees
 group by dept,hire_date
 order by dept asc,hire_date desc;


-- having clause

  select 
     dept,
	 round  (avg (salary), 2) as avg_salary
	 from employees
	 group by dept
	 having avg (salary) > 20000;

   --select
   --<col_>,
   --<col_>,
   --<col_>
   --from <table_name>
   --where<condition> and <condition_2> and <condition_3> or <cond_4>
   --group by <col_1>, <col_2>
   --having <condition.
   --order by <col_1>, <col_2>

--Q find the dept with more than 2 employees

 select 
     dept, 
	 count (*)
	 from employees
	 group by dept
	 having count (*) >2
	
-- Q Find the dept where the total salary expenditure is grater 50000

select
dept,
sum(salary)
from employees
group by dept
having sum (salary) > 50000;
	
--Q find the dept where: the average salary is grater than 30000, and the number of employees is grater than 1.

select 
   dept,
   round(avg (salary),2) as avg_salary, count(emp_id) as no_of_employees
   from employees
   group by dept
    having avg(salary) > 10000 and count(emp_id) > 1

select 
dept,
round(avg (salary),2) as avg_salary, count(emp_id) as no_of_employees
   from employees
   where age >= 25
   group by dept
   having avg(salary) > 10000 and count(emp_id) > 1


--subqueries

select * from
(select * from employees)

--in select
select
emp_id,
emp_name,
salary,
salary - (select avg(salary) from employees)
from employees;
	
--Q: Employees who earn more than avg salary 

select * from employees
 where salary > (select avg(salary) from employees);

--Q:  retrive the employee name,salary, and the different between their salary and the avg salary

select 
  	 name,
	 salary as monthly_salary,
 salary - (select avg(salary) from employees) as sallary_difference
from employees;

select 
   name,
   salary as monthly_salary,
   round (salary- (select avg(salary) from employees),2) as salary_difference
   from employees;

--Write a query to retrieve employees whose salary is greater than the highest salary in the "Finance" department. [HINT: Use subquery in where condition]
select name, salary
from employees 
where salary > (select max(salary) from employees
where dept = 'finance')

--alter the specific record 
 syntax
--alter <table_name>
--select <col_1> = <value>
--where condition

update employees
set salary = 69000
where emp_id = 4;

select * from employees
order by 1

update employees
set dept = 'marketing'
where emp_id = 5;

select * from employees
order by 1;

select * from dept

--alter a column name 
syntax
--alter table <table_name>
--rename to new_table_name>;
alter table employees
rename to emp
	
	select * from employees

--alter a column data type
syntax
--alter table <table_name>
--alter new_table_name>;
alter table employees
alter emp_name type varchar (50);

select * from employees
order by 1

--alter a table name

syntax
--alter table <table_name>
--rename to new_table_name>;

alter table depts
rename to dept

select * from dept


--transaction 
--workd when using DML	

begin;

update employees
set dept = 'IT'
where emp_id = 7;

commit;

rollback;

select * from employees
order by 1

----------------------------------------------------------------
begin;

alter table dept
rename to depts;

commit;

DDL : data defination Language
create - creates  a database object (table,schema)
alter -

Order by 1;
-------------------------------------------------------

DDL : Data Definition Language

CREATE - Creates a database object (table, schema)

ALTER - Modifies the database object (column names, data types, table structure)

DROP - DELETING A TABLE

TRUNCATE - Removing the data inside a table

DROP TABLE employees

TRUNCATE - Removing the data inside a table

Truncate table employees;

------------------------------------------------------------

DML: Data Manipulation Language

INSERT - Adds new data into a table

UPDATE - Modifies existing data

DELETE - Removes data

Syntax

-- DELETE FROM <TABLE_NAME> WHERE condition;
---------------------------------------------------------------------------------

select * from emplovees

TCL: Transaction Control Language

BEGIN - Starts a transaction

COMMIT - Saves changes

ROLLBACK - Reverts changes

SAVEPOINT - Sets a point to roll back to

-----------------------------------------------------------------------------------

update employees
set department = 'IT'
where emp_id = 7;

update employees
set department = 'Finance'
where emp_id = 1;

SAVEPOINT day1;
update employees
set department = 'Finance'
where emp_id = 10;

update employees
set department = 'IT'
where emp_id = 8;

SAVEPOINT day2;
update employees
set department = 'Marketing'
where emp_id = 2;

update employees
set department = 'IT'
where emp_id = 11;

SAVEPOINT day3;

---------------------------------------------------------------------------------------------------------------------
select * from employees

 --window function 

 --Rankig Function 
   --Row_Number	
   --Rank
   --DENSE_Rank
   --NITLE

 --Aggregate Function
   --SUM
   --AVG
   --COUNT

 --Value Function 
   --LAG
   --LEAD

---------------------------------------------------------------------------------------------------------------------
 --Ranking Function 
   --Row_Number

  select 
          *
		   ,row_number() over (partition by dept) as row_num 
   from employees

 --Rank
   select 
          *
		   ,row_number() over (partition by dept order by salary desc) as row_num 
   from employees

 --DENSE_Rank

   select 
         *
		  ,dense_rank() over (partition by dept order by salary desc) as row_num
	from employees

-- NTILE(n) : Divide the rows into N groups as evenly as possible

  select 
        *
         ,ntile(3) over (order by salary desc) as split_group
  from employees

  -- Avrage Window function 
  ---- SUM()

select
*
,sum(salary) over (partition by dept) as dept_total_salary
from employees

-- AVG
	select
	*
	,round((avg(salary) over (partition by dept)),2) as dept_avg_salary
	from employees

-- COUNT
select
*
,count(*) over (partition by dept) as dept_total_count
from employees

--Running total(cumulative sum)

  select
      name
	  ,dept
	  ,hire_date
	  ,salary
	  ,sum(salary)over (order by hire_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
  from employees

--------------------
--value function 
--LAG()

 select 
       name
	   ,dept
	   ,hire_date
	   ,salary
	   ,lag(salary) over (order by hire_date) as prev_salary
  from employees

   select 
       name
	   ,dept
	   ,hire_date
	   ,salary
	   ,lag(salary) over (partition by dept order by hire_date) as prev_salary
  from employees

-- LEAD
select
name
,dept
,hire_Date
,salary
,lead (salary) over (order by hire_date) as prev_salary
from employees




