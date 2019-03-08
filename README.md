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





