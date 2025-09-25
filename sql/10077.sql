/*
https://platform.stratascratch.com/coding/10077-income-by-title-and-gender/solutions?code_type=1
Find the average total compensation based on employee titles and gender. Total compensation is calculated by adding both the salary and bonus of each employee. However, not every employee receives a bonus so disregard employees without bonuses in your calculation. Employee can receive more than one bonus.
Output the employee title, gender (i.e., sex), along with the average total compensation.

Difficulty: Medium

Tables:
<sf_employee>
address			text
age				bigint
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

<sf_bonus>
worker_ref_id	bigint
bonus			bigint
*/

WITH total_bonus AS (
    SELECT 
        worker_ref_id,
        SUM(bonus) AS bonus
    FROM sf_bonus
    GROUP BY worker_ref_id
),
total_comp AS (
    SELECT
        e.employee_title,
        e.sex,
        (e.salary + b.bonus) AS total_comp
    FROM sf_employee e
    JOIN total_bonus b
        ON e.id = b.worker_ref_id
)
SELECT
    employee_title,
    sex,
    AVG(total_comp) AS avg_total_comp
FROM total_comp
GROUP BY 
    employee_title, 
    sex;
