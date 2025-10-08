/*
https://platform.stratascratch.com/coding/9739-worst-businesses?code_type=1
Identify the business with the most violations each year, based on records that include a violation ID. For each year, output the year, the name of the business with the most violations, and the corresponding number of violations.

Difficulty: Hard

Tables:
<sf_restaurant_health_violations>
business_address			text
business_city				text
business_id					bigint
business_latitude			double precision
business_location			text
business_longitude			double precision
business_name				text
business_phone_number		double precision
business_postal_code		double precision
business_state				text
inspection_date				date
inspection_id				text
inspection_score			double precision
inspection_type				text
risk_category				text
violation_description		text
violation_id				text
*/

WITH ranked_violations AS (
    SELECT
        EXTRACT(YEAR FROM inspection_date) AS year,
        business_name,
        COUNT(*) AS num_violations,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM inspection_date)
            ORDER BY COUNT(*) DESC
        ) AS rnk
    FROM sf_restaurant_health_violations
    WHERE violation_id IS NOT NULL
    GROUP BY
        business_name,
        EXTRACT(YEAR FROM inspection_date)
)
SELECT
    year,
    business_name,
    num_violations
FROM ranked_violations
WHERE rnk = 1;
