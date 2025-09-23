/*
https://platform.stratascratch.com/coding/9905-highest-target-under-manager?code_type=1
Identify the employee(s) working under manager manager_id=13 who have achieved the highest target. Return each such employee’s first name alongside the target value. The goal is to display the maximum target among all employees under manager_id=13 and show which employee(s) reached that top value.

Difficulty: Medium

Tables:
<salesforce_employees>
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

WITH ranked_target AS(
SELECT
    first_name,
    target,
    RANK() OVER (ORDER BY target DESC) AS rank
FROM salesforce_employees
WHERE manager_id = 13
)
SELECT 
    first_name,
    target
FROM ranked_target
WHERE rank = 1
ORDER BY month
