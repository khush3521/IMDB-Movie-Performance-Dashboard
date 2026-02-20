USE project_movie_database;

-- 1) Can you get all data about movies?
SELECT * 
FROM movies;

-- 2) How do you get all data about directors?
SELECT * 
FROM directors;

-- 3) Check how many movies are present in IMDB
select count(*) as total_movie from  movies;

-- 4) Find these 3 directors: James Cameron ; Luc Besson ; John Woo
SELECT *
FROM directors
WHERE name IN ('James Cameron', 'Luc Besson', 'John Woo');

-- 5) Find all directors with name starting with S.
SELECT count(*) as startwiths
FROM directors
WHERE name LIKE 'S%';

-- 6) Count female directors
SELECT *
FROM directors
WHERE gender = 1;

-- 7) Find the name of the 10th first women director
SELECT name
FROM directors
WHERE gender = 1
ORDER BY name
LIMIT 1 OFFSET 9;

-- 8) What are the 3 most popular movies?
SELECT title, popularity
FROM movies
ORDER BY popularity DESC
LIMIT 3;

-- 9) What are the 3 most bankable movies?
SELECT title, revenue
FROM movies
ORDER BY revenue DESC
LIMIT 3;

-- 10) What is the most awarded average vote since January 1st, 2000?
SELECT title, vote_average
FROM movies
WHERE release_date >= '2000-01-01'
ORDER BY vote_average DESC
LIMIT 1;

-- 11) Which movie(s) were directed by Brenda Chapman?
SELECT *
FROM directors
WHERE name LIKE '%Brenda Chapman%';

-- 12) Which director made the most movies?
SELECT d.name, COUNT(m.id) AS total_movies
FROM directors d
JOIN movies m
ON d.id = m.director_id
GROUP BY d.name
ORDER BY total_movies DESC
LIMIT 1;

-- 13) Which director is the most bankable?
SELECT d.name, SUM(m.revenue) AS total_revenue
FROM directors d
JOIN movies m
ON d.id = m.director_id
GROUP BY d.name
ORDER BY total_revenue DESC
LIMIT 1;










