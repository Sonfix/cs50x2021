-- needed to check this https://cs50.stackexchange.com/questions/35255/pset7-movies-q13-sql-how-to-not-include-kevin-bacon-in-list-of-actors-that-h
-- because I also got Kevon Bacon in my result record set

SELECT DISTINCT(name) FROM people
WHERE name IS NOT 'Kevin Bacon'
AND id IN (
    SELECT person_id FROM stars Where movie_id IN (
        SELECT movie_id FROM stars Where person_id IN (
            SELECT id FROM people WHERE name IS 'Kevin Bacon' and birth = 1958)
        )
    )
ORDER BY name;