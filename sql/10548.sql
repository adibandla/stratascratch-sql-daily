/*
https://platform.stratascratch.com/coding/10548-top-actor-ratings-by-genre?code_type=1
Find the top actors based on their average movie rating within the genre they appear in most frequently.
For each actor, determine their most frequent genre (i.e., the one they’ve appeared in the most).
If there is a tie in genre count, select the genre where the actor has the highest average rating.
If there is still a tie in both count and rating, include all tied genres for that actor.


Rank all resulting actor + genre pairs in descending order by their average movie rating.
Return all pairs that fall within the top 3 ranks (not simply the top 3 rows), including ties.
Do not skip rank numbers — for example, if two actors are tied at rank 1, the next rank is 2 (not 3).

Difficulty: Hard

Tables:
<top_actors_rating>
actor_name			text
genre				text
movie_rating		double precision
movie_title			text
production_company	text
release_date		date
*/

WITH actor_genre_stats AS (
    SELECT
        actor_name,
        genre,
        COUNT(*) AS genre_count,
        AVG(movie_rating) AS avg_genre_rating
    FROM top_actors_rating
    GROUP BY actor_name, genre
),
actor_top_genre AS (
    SELECT
        actor_name,
        genre,
        avg_genre_rating,
        DENSE_RANK() OVER (
            PARTITION BY actor_name 
            ORDER BY genre_count DESC, avg_genre_rating DESC
        ) AS genre_rank
    FROM actor_genre_stats
),
ranked_actors AS (
    SELECT
        actor_name,
        genre,
        avg_genre_rating,
        DENSE_RANK() OVER (ORDER BY avg_genre_rating DESC) AS global_rank
    FROM actor_top_genre
    WHERE genre_rank = 1
)
SELECT *
FROM ranked_actors
WHERE global_rank <= 3;
