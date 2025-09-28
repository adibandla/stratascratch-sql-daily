/*
https://platform.stratascratch.com/coding/2060-manager-of-the-largest-department?code_type=1
Given a list of a company’s employees, find the first and last names of all employees whose position contains the word “manager” and who work in the largest department(s) — that is, departments with the highest number of employees. If multiple departments share the same largest size, return managers from all such departments.

Difficulty: Medium

Tables:
<az_employees>
department_id		bigint
department_name		text
first_name			text
id					bigint
last_name			text
position			text
*/

WITH ranked_dept AS(
    SELECT
        department_name,
        RANK() OVER (ORDER BY COUNT(DISTINCT id) DESC) AS dept_rank
    FROM az_employees
    GROUP BY department_name
)
SELECT
    first_name,
    last_name
FROM az_employees AS e
JOIN (SELECT department_name FROM ranked_dept WHERE dept_rank = 1) AS d
USING(department_name)
WHERE position ILIKE '%manager%'
