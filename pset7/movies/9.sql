SELECT DISTINCT(p.name) FROM people p, stars s, movies m WHERE s.person_id = p.id AND s.movie_id = m.id AND m.year = 2004 ORDER BY p.birth;