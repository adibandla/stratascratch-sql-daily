/*
https://platform.stratascratch.com/coding/9894-employee-and-manager-salaries?code_type=1
Find employees who are earning more than their managers. Output the employee's first name along with the corresponding salary.

Difficulty: Medium

Tables:
<employee>
address			text
age				bigint
bonus			bigint
city			text
department		text
email			text
employee_title	text
first_name		text
id				bigint
last_name		text
manager_id		bigint
salary			bigint
sex				text
target			bigint
*/

SELECT 
    sales.first_name,
    sales.salary AS salary
FROM (SELECT * FROM employee) AS sales
JOIN (SELECT * FROM employee WHERE employee_title = 'Manager') AS manager
ON sales.manager_id = manager.id
WHERE manager.salary < sales.salary
