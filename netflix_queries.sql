-- 1. Count total Movies vs TV Shows
SELECT type, COUNT(*) AS total
FROM netflix
GROUP BY type;

-- 2. Top 10 countries with the most Netflix titles
SELECT country, COUNT(*) AS total_titles
FROM netflix
WHERE country != 'Unknown'
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;

-- 3. Distribution of content by rating
SELECT rating, COUNT(*) AS count
FROM netflix
GROUP BY rating
ORDER BY count DESC;

-- 4. New titles added each year (trend over time)
SELECT added_year, COUNT(*) AS titles_added
FROM netflix
GROUP BY added_year
ORDER BY added_year;

-- 5. Top 10 directors with the most content
SELECT director, COUNT(*) AS total_content
FROM netflix
WHERE director != 'Unknown'
GROUP BY director
ORDER BY total_content DESC
LIMIT 10;

-- 6. Most common genres (listed_in)
SELECT genre, COUNT(*) AS total
FROM (
    SELECT TRIM(value) AS genre
    FROM netflix, 
         json_each('["' || REPLACE(listed_in, ', ', '","') || '"]')
)
GROUP BY genre
ORDER BY total DESC
LIMIT 10;

-- 7. Average duration of movies (in minutes)
SELECT ROUND(AVG(duration_min), 2) AS avg_movie_duration
FROM netflix
WHERE type = 'Movie';

-- 8. TV Shows with the most seasons
SELECT title, num_seasons
FROM netflix
WHERE type = 'TV Show'
ORDER BY num_seasons DESC
LIMIT 10;

-- 9. Oldest released movie still on Netflix
SELECT title, release_year
FROM netflix
WHERE type = 'Movie'
ORDER BY release_year ASC
LIMIT 1;

-- 10. Most recent content added
SELECT title, type, date_added
FROM netflix
ORDER BY date_added DESC
LIMIT 10;