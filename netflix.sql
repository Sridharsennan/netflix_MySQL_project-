-- Data Analysis for netflix using MySql
-- Data cleaning and solutions for the problems

-- Checking for duplicates

SELECT show_id,`type`,title, director,`cast`,country,
date_added,release_year, rating, duration,listed_in,`description`, COUNT(*)FROM netflix.netflix_titles
GROUP BY show_id,`type`,title, director,`cast`,country,
date_added,release_year, rating, duration,listed_in,`description`
HAVING count(*)>0;

-- 1. Count the number of movies vs TV shows

SELECT  `type`, count(*) as Total FROM netflix_titles
GROUP BY `type`;

-- 2. Find the most common rating for movies and TV shows

SELECT 
type, rating, COUNT(*) AS count_of_common_rating  
FROM netflix_titles
GROUP BY type, rating
ORDER BY type, count_of_common_rating DESC;

-- 3. List all movies released in a specific year

SELECT title AS movies, release_year FROM netflix_titles
WHERE type = 'movie'
ORDER BY release_year DESC;

-- 4. Find the top 5 countries with the most content on Netflix

SELECT country, COUNT(type) FROM netflix_titles
group by country;


-- 5. Identify the longest movie or TV show duration

SELECT `type`, title, duration 
FROM netflix_titles
ORDER BY `type`, duration DESC;

-- 6. Identify the longest movie
SELECT * FROM netflix_titles
WHERE `type`= 'Movie'
AND duration = (SELECT max(duration) FROM netflix_titles);

-- 7. Find content added in the last 5 years
SELECT * FROM netflix_titles;
SELECT *
FROM netflix_titles
WHERE date_added >= curdate() - INTERVAL 5 YEAR;

-- 8. Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT * FROM netflix_titles
WHERE director = 'Rajiv Chilaka';

-- 9. List all TV shows with more than 5 seasons

SELECT `type`, title, duration FROM netflix_titles
WHERE `type` = 'TV Show'
AND duration > '5 Seasons';


-- 10.Find each year and the average numbers of content release in India on netflix and
-- return top 5 year with highest avg content release!

SELECT release_year, 
       AVG(show_id) AS avg_content_release
FROM (
    SELECT release_year, 
           COUNT(*) AS show_id
    FROM netflix_titles
    WHERE country = 'India'
    GROUP BY release_year
) AS yearly_content
GROUP BY release_year
ORDER BY avg_content_release DESC
LIMIT 5;


-- 11. List all movies that are documentaries

SELECT * FROM netflix_titles
WHERE listed_in LIKE '%Documentaries';

-- 12. Find all content without a director

SELECT * FROM netflix_titles
WHERE director like '' ;

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT `type`, title, `cast` date_added FROM netflix_titles
WHERE `cast` LIKE '%Salman Khan%'
AND release_year > YEAR(CURDATE()) - 10;

