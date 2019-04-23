index: we ca nuse an index that will increase the speed of searches related to a table

create index index_name on table_name (col_1, col_2, ...);

e.g.

1. select * from employees where hire_date > '2000-01-01';

2. create index i_hire_date on employees(hire_date);

Tip:

try 1 first and record the process time; 

excute 2 and try 1 again, you will find the later time largely increased speed. 


compositie indexes

applied to multiple columns, not just a single one

carefully pick the columns that would optimize your search!

select * from employees where first_name = 'Georgi' and last_name = 'Facello';

create index i_composite on employees(first_name, last_name);

primany and unique keys are MySQL index


how to check index?

1. click the info button from left side schema
2. show index from employees(table) from employees(database);

how to drop index?

alter table employees drop index i_hire_date;

index is more useful when dealing with large dataset.
