/*
https://platform.stratascratch.com/coding/10304-risky-projects?code_type=1
You are given a set of projects and employee data. Each project has a name, a budget, and a specific duration, while each employee has an annual salary and may be assigned to one or more projects for particular periods. The task is to identify which projects are overbudget. A project is considered overbudget if the prorated cost of all employees assigned to it exceeds the project’s budget.


To solve this, you must prorate each employee's annual salary based on the exact period they work on a given project, relative to a full year. For example, if an employee works on a six-month project, only half of their annual salary should be attributed to that project. Sum these prorated salary amounts for all employees assigned to a project and compare the total with the project’s budget.


Your output should be a list of overbudget projects, where each entry includes the project’s name, its budget, and the total prorated employee expenses for that project. The total expenses should be rounded up to the nearest dollar. Assume all years have 365 days and disregard leap years.

Difficulty: Medium

Tables:
<linkedin_projects>
budget		bigint
end_date	date
id			bigint
start_date	date
title		text

<linkedin_emp_projects>
emp_id		bigint
project_id	bigint

<linkedin_employees>
first_name	text
id			bigint
last_name	text
salary		bigint
*/

WITH actual_budgets AS (
    SELECT 
        projects.title AS title,
        budget,
        CEILING(
        SUM((salary * (end_date - start_date)::float / 365))
        ) AS prorated_employee_expense
    FROM linkedin_projects AS projects
    JOIN linkedin_emp_projects AS emp
    ON projects.id = emp.project_id
    JOIN linkedin_employees AS salary
    ON emp.emp_id = salary.id
    GROUP BY title, budget
    ORDER BY title ASC
)
SELECT 
    title,
    budget,
    prorated_employee_expense
FROM actual_budgets
WHERE prorated_employee_expense > budget
