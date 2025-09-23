/*
https://platform.stratascratch.com/coding/10318-new-products?code_type=1
Calculate the net change in the number of products launched by companies in 2020 compared to 2019. Your output should include the company names and the net difference.
(Net difference = Number of products launched in 2020 - The number launched in 2019.)

Difficulty: Medium

Tables:
<car_launches>
company_name  text
product_name  text
year          bigint
*/

SELECT 
    company_name, 
    COUNT(DISTINCT product_name) FILTER(WHERE year = 2020) 
    - 
    COUNT(DISTINCT product_name) FILTER(WHERE year = 2019) 
    AS net_products
FROM car_launches
GROUP BY company_name
