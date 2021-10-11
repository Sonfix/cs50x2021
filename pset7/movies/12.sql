-- with a little help from the internet -> https://stackoverflow.com/questions/61536261/cs50-pset7-movies-sql-12

SELECT m.title FROM stars s
    JOIN movies m ON s.movie_id = m.id
    JOIN people p ON s.person_id = p.id
WHERE p.name IN ('Johnny Depp', 'Helena Bonham Carter')
GROUP BY m.title
HAVING COUNT(m.title) = 2;