/*
https://platform.stratascratch.com/coding/9897-highest-salary-in-department?code_type=1
Find the employee with the highest salary per department.
Output the department name, employee's first name along with the corresponding salary.

Difficulty: Medium

Tables:
<employee>
address				text
age					bigint
bonus				bigint
city				text
department			text
email				text
employee_title		text
first_name			text
id					bigint
last_name			text
manager_id			bigint
salary				bigint
sex					text
target				bigint
*/

WITH ranked_salaries AS(
SELECT
    department,
    first_name,
    salary,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank
FROM employee
) 
SELECT
    department,
    first_name,
    salary
FROM ranked_salaries
WHERE rank = 1
