SQL
===

how to download mysql on Mac?

1. mysql workbench
2. mysql server -- create password and remember it.


This file shows basic commands in SQL.

* Create table

* Query table

* Aggregating data

* Queries with AND OR

* Query IN subqueries

* Restricting Grouped Results with HAVING

* Calculating results with CASE

* JOINing tables

* Joining related tables with LEFT OUTER JOIN

* Changing Rows with UPDATE and DELETE

*hit: “We’re” does not work; but “We are ” works.

* ALTERing tables after creation

* Joining tables to themselves with self joins

* Combining multiple joins

MySQL is not case-sensitive.

Wildcard Characters:
==

'%' -- a substitute for a sequence of characters 

like ('Mar%') --> Mark, Martin, Margaret

'_' -- helps you match a single character

like ('Mar_') --> Mark, Marv, Marl

'*' --will deliver a list of all columns in a table, it can be used to count all rows of a table.

create database
==

create database [if not exists] database_name;

create schema [if not exists] database_name;

before work on tables first need to tell computer which database you want to work on: use database_name;

create tables
==

create table table_name (
  
  column_1 data_type constraints,
  
  column_2 data_type constraints,
  
  ...

  column_n data_type constraints,
  
);

select rules:
==

select column_names(s)

from table_name

where conditions

group by column_names

having conditions (having is like where but applied to the group by block)

order by column_names (default:asc);


Note: after having, you can have a condition with an aggregate function(count, sum, min, max, avg), while where cannot use aggregate functions within its conditions.

how to limit the output quantity?

1. add to the end of query such as limit 10;

2. go to edit --> preference--> SQL Editor --> SQL Execution;

3. select from the top list of the query on workbench, which default as 'limit to 1000 rows'.

insert rules:
==

1. insert record(s)

insert into table_name (column1, column2, ..., columnn) values (value1, value2, ..., valuen);

2. insert table

insert into table_2 (column1, column2, ..., columnn)

select column1, column2, ..., columnn

from table_1;


update rules;
==

note: you don't need to update all columns after set, just the columns you want to udpate.

update table_name

set

  column1 = value1, column2 = value2,...

where conditions;


delete rules;
==

delete from table_naem
where conditions;

drop vs truncate vs delete
==

drop: once you drop a table, it is gone; you cannot roll back to its initial state, or to the last commit statement;

truncate: delete without a where 

*when truncating, auto-increment value will be reset*

delete: removes records row by row


*Foreeign key constraint*

on delete cascade

if a specific value from the parent table's primary key has been deleted, all the records from the child table referring to this value will be removed as well.


commit;
rollback;

sounds like a combo of regret medicine.


aggregation function
==
execpt count, sum, min, max, and avg, we also have the following:

1. round(expression, decimal number)

2. ifnull(expression1, expression2)  -- only two parameter -- if the first expression does not satisfied, it will go to the second one

3. coalesce(expressions) -- ifnull() with more than two parameters -- it will go from the left expression to the right until it found out the not null value.

join
==

1. (inner) join -- it finds out the common content between two tables based on the same criteria.

select t1. column_name1, t1.column_name2, t2.column_name3 from table1 t1 inner join table2 t2 on t1.column_name1 = t2.column_name1 order by t1.column_name1;

in order to use group by in join to remove duplicates:

```
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
```

2. left (outer) join -- inner join plus all values from the left table that match no values from the right table

select t1. column_name1, t1.column_name2, t2.column_name3 from table1 t1 left join table2 t2 on t1.column_name1 = t2.column_name1 order by t1.column_name1;

if you want to get the part all values from the left table that match no values from the right table, you should use where conditions which is 

select t1. column_name1, t1.column_name2, t2.column_name3 from table1 t1 left join table2 t2 on t1.column_name1 = t2.column_name1 **where columnname3(column in right table) is null** order by t1.column_name1;

3. right (outer) join -- inner join plus all values from the right table that match no values from the left table

*Right join seldom run into practice, we can reverse table order of left join to achieve right join*

4. cross join -- connects qll the values, not jus those that match -- Cartesian Product (vector * vector) 直积

*This suppose table in the database does not connect*

Computer regards join without on as crosss join. But it is not recommendation to use it, cross join is best practice. 

5. join more than two tables

select e.first_name, e.last_name, e.hire_date, m.from_date, d.dept_name from employees e join dept_manager m on e.emp_no = m.emp_no join departments d on m.dept_no = d.dept_no;

6. union vs union all

select e.emp_no, e.first_name, e.last_name, null as dept_no, null as from_date from employees_dup e where e.emp_no = 10001 union (all) select null as emp_no, null as first_name, null as last_name, m.dept_no, m.from_date from dept_manager m;

union displays only distinct values in the output while union all retrieves duplicates as well

7. sub query inner query -- always placed within parentheses

select e.first_name, e.last_name from employees e where e.emp_no in (select dm.emp_no from dept_manager dm);

view --show up-to-date data & save coding time
==

SQL view : a virtual table whose contents are obtained from an existing table(s), called base tables. 

```
CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
    SELECT 
        emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM
        dept_emp
    GROUP BY emp_no;
```

Stored Routines (stored procedures & functions)
==

### Stored Procedures

Definition: an SQL statement, or a set of SQL statements, that can be stored on the database server

Delimiter: $$ or //

```
delimiter $$

create procedure procedure_name()
begin
  select ...;
end$$

delimiter;

```
call or invoke this procedure

```
call database_name.procedure_name();
```
or 
if it is already in the database
```
call procedure_name();
```
or
just click on the excute button near the procedure name in left schemas (looks like flash). *the tool icon tells you whole procedure code.

use in in parameter
```
Delimiter $$
use employees $$
create procedure emp_avg_salary(in p_emp_no integer)
begin
	select e.first_name, e.last_name, s.salary, avg(s.salary) as Avg_Salary from employees e join salaries s on e.emp_no = s.emp_no where e.emp_no =p_emp_no;
end$$
Delimiter ;
```
use in and out in parameter
```
Delimiter $$
use employees $$
create procedure emp_avg_salary_out(in p_emp_no integer, out p_avg_salary decimal(10,2))
begin
	select avg(s.salary) as Avg_Salary into p_avg_salary from employees e join salaries s on e.emp_no = s.emp_no where e.emp_no =p_emp_no;
end$$
Delimiter ; 
```
variables

1) create a variable

2) extract a value that will be assigned to the newly created variable(call the procedure)

3) ask the software to display the output of the procedure

```
set @v_avg_salary = 0;
call employees.emp_avg_salary_out(11300, @v_avg_salary);
select @v_avg_salary;
```

### Functions

```
Delimiter $$
create function f_emp_avg_salary (p_emp_no integer) returns decimal(10,2)
begin
declare v_avg_salary decimal(10,2);
select avg(s.salary) into v_avg_salary from employees e join salaries s on e.emp_no = s.emp_no where e.emp_no = p_emp_no;
return v_avg_salary;
end$$
delimiter ;
```
*if you cannot laod the above query, exucute the below query first
```
SET GLOBAL log_bin_trust_function_creators = 1;
```
how to call a function?
```
select f_emp_avg_salary(11300);
```


Session Variable

A variable that exists only for the session in which you are operating

