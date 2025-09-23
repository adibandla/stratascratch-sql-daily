/*
https://platform.stratascratch.com/coding/9726-classify-business-type?code_type=1
Classify each business as either a restaurant, cafe, school, or other.


•	A restaurant should have the word 'restaurant' in the business name. This includes common international or accented variants, such as “restaurante”, “restauranté”, etc.
•	A cafe should have either 'cafe', 'café', or 'coffee' in the business name.
•	A school should have the word 'school' in the business name.
•	All other businesses should be classified as 'other'.
• 	Ensure each business name appears only once in the final output. If multiple records exist for the same business, retain only one unique instance.


The final output should include only the distinct business names and their corresponding classifications.

Difficulty: Medium

Tables:
<sf_restaurant_health_violations>
business_address		text
business_city			text
business_id				bigint
business_latitude		double precision
business_location		text
business_longitude		double precision
business_name			text
business_phone_number	double precision
business_postal_code	double precision
business_state			text
inspection_date			date
inspection_id			text
inspection_score		double precision
inspection_type			text
risk_category			text
violation_description	text
violation_id			text
*/

SELECT
    DISTINCT business_name,
    CASE WHEN business_name ~* 'restaurant|restaurante|restauranté' THEN 'restaurant'
    WHEN business_name ~* 'cafe|café|coffee' THEN 'cafe'
    WHEN business_name ~* 'school' THEN 'school'
    ELSE 'other'
    END AS business_type
FROM sf_restaurant_health_violations
