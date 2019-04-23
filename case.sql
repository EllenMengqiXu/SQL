case: if column_A contains value_A return Alice, otherwise return Bryan.

select col_name(s) 
 case condition_filed 
  when condition_field_value_1 then result_1
  when condition_field_value_2 then result_2
  ...
  else
 end as
from table_name;

e.g.

SELECT 
    emp_no,
    first_name,
    last_name,
    CASE
        WHEN gender = 'M' THEN 'Male'
        ELSE 'Female'
    END AS gender
FROM
    employees;
    
SELECT 
    emp_no,
    first_name,
    last_name,
    CASE gender
        WHEN 'M' THEN 'Male'
        ELSE 'Female'
    END AS gender
FROM
    employees; 

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'manager'
        ELSE 'employees'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
WHERE
    e.emp_no > 109990;
    
select emp_no, first_name, last_name, if(gender='M', 'Male', 'Female') as gender from employees;

if vs case

if: one condition
case: multiple conditions
