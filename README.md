SQL
===

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




