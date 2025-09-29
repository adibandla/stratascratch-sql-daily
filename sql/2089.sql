/*
https://platform.stratascratch.com/coding/2089-cookbook-recipes?code_type=1
You are given a table containing recipe titles and their corresponding page numbers from a cookbook. Your task is to format the data to represent how recipes are distributed across double-page spreads in the book.

Each spread consists of two pages:
The left page (even-numbered) and its corresponding recipe title (if any).
The right page (odd-numbered) and its corresponding recipe title (if any).

The output table should contain the following three columns:
left_page_number – The even-numbered page that starts each double-page spread.
left_title – The title of the recipe on the left page (if available).
right_title – The title of the recipe on the right page (if available).

For the  k-th  row (starting from 0):
The  left_page_number  should be 2 × k.
The  left_title  should be the title from page 2 × k, or NULL if there is no recipe on that page.
The  right_title  should be the title from page 2 × k + 1, or NULL if there is no recipe on that page.

Each page contains at most one recipe and  if a page does not contain a recipe, the corresponding title should be NULL. Page 0 (the inside cover) is always empty and included in the output. Only include spreads where at least one of the two pages has a recipe.

Difficulty: Hard

Tables:
<cookbook_titles>
page_number			bigint
title				text
*/

WITH spread_num AS(
SELECT
    2 * (ROW_NUMBER() OVER () - 1) AS left_page_number,
    2 * (ROW_NUMBER() OVER () - 1) + 1 AS right_page_number
FROM cookbook_titles
)
SELECT
    s.left_page_number,
    a.title AS left_title,
    b.title AS right_title
FROM spread_num AS s
LEFT JOIN cookbook_titles AS a
    ON s.left_page_number = a.page_number
LEFT JOIN cookbook_titles AS b
    ON s.right_page_number = b.page_number
WHERE 
    a.title IS NOT NULL 
    OR b.title IS NOT NULL
