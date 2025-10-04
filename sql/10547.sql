/*
https://platform.stratascratch.com/coding/10547-actor-rating-difference-analysis?code_type=1
You are given a dataset of actors and the films they have been involved in, including each film's release date and rating. For each actor, calculate the difference between the rating of their most recent film and their average rating across all previous films (the average rating excludes the most recent one).

Return a list of actors along with their average lifetime rating, the rating of their most recent film, and the difference between the two ratings. Round the difference calculation to 2 decimal places. If an actor has only one film, return 0 for the difference and their only film’s rating for both the average and latest rating fields.

Difficulty: Hard

Tables:
<actor_rating_shift>
actor_name			text
film_rating			double precision
film_title			text
release_date		date
*/

WITH ratings AS (
    SELECT
        actor_name,
        film_rating,
        RANK() OVER (
            PARTITION BY actor_name 
            ORDER BY release_date DESC
        ) AS rnk,
        COUNT(*) OVER (PARTITION BY actor_name) AS num_movies
    FROM actor_rating_shift
),
most_recent_films AS (
    SELECT
        actor_name,
        film_rating AS most_recent_film
    FROM ratings
    WHERE rnk = 1
),
avg_lifetime_rating AS (
    SELECT
        actor_name,
        AVG(film_rating) AS avg_lifetime_rating
    FROM ratings
    WHERE rnk > 1
    GROUP BY actor_name
)
SELECT
    a.actor_name,
    a.most_recent_film,
    COALESCE(b.avg_lifetime_rating, a.most_recent_film) AS avg_lifetime_rating,
    ROUND(
		COALESCE(a.most_recent_film - b.avg_lifetime_rating, 0)::numeric, 
		2
	) AS diff
FROM most_recent_films AS a
LEFT JOIN avg_lifetime_rating AS b 
USING (actor_name);
