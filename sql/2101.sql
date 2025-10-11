/*
https://platform.stratascratch.com/coding/2101-maximum-of-two-numbers?code_type=1
Given a single column of numbers, consider all possible permutations of two numbers with replacement, assuming that pairs of numbers (x,y) and (y,x) are two different permutations. Then, for each permutation, find the maximum of the two numbers.

Output three columns: the first number, the second number and the maximum of the two.

Difficulty: Medium

Tables:
<deloitte_numbers>
number:			bigint
*/

SELECT
    a.number AS first_number,
    b.number AS second_number,
    CASE 
        WHEN a.number > b.number THEN a.number 
        ELSE b.number 
    END AS maximum
FROM deloitte_numbers AS a
CROSS JOIN deloitte_numbers AS b;
