-- trovare le città che non hanno attività associate
SELECT city.id, city.name
FROM city LEFT JOIN business ON city.id = business.city
WHERE business.city is NULL;

-- estrarre i servizi non offerti da attività di Las Vegas in NV
WITH business_las_vegas as (
    SELECT business.id 
    FROM business INNER JOIN city ON city.id = business.city
    WHERE city.name = 'Las Vegas' AND country = 'NV'),
    services_las_vegas as (
        SELECT distinct feature
        FROM services INNER JOIN business_las_vegas ON services.business = business_las_vegas.id)
        SELECT feature.name
        FROM feature LEFT JOIN services_las_vegas ON feature.name = services_las_vegas.feature
        WHERE services_las_vegas.feature IS NULL;

-- restituire il nome delle attività che non risultano aperte di lunedì (si veda la tabella schedule)
WITH open_monday as (
    SELECT business
    FROM schedule
    WHERE day = 'monday')
    SELECT id, name
    FROM business LEFT JOIN open_monday ON business.id = open_monday.business
    WHERE open_monday.business IS NULL;

-- estrarre le attività che sono solo nella categoria "burgers"
SELECT business
FROM incat
WHERE category = 'burgers'
EXCEPT
SELECT business
WHERE category <> 'burgers';

-- trovare le attività che non sono recensite da revisori con meno di 4 stelle di media (cioè i revisori con reviewer.average_stars >= 4)
with top_reviewers as (
    SELECT id
    FROM reviewer
    WHERE average_stars >= 4)
    SELECT id
    FROM business
    EXCEPT
    SELECT business
    FROM review INNER JOIN top_reviewers ON top_reviewers.id = review.reviewer; 

-- il nome delle attività che offrono sia servizi di WheelchairAccessible sia di BusinessParking_valetSELECT business
SELECT business
FROM services 
WHERE feature = 'WheelchairAccessible' 
INTERSECT
SELECT business
FROM services 
WHERE feature = 'BusinessParking_valet';

-- estrarre le attività che offrono 'WheelchairAccessible' o 'BusinessParking_valet'
SELECT business
FROM services 
WHERE feature = 'WheelchairAccessible' OR feature = 'BusinessParking_valet';
-- oppure:
SELECT business
FROM services 
WHERE feature = 'WheelchairAccessible' 
UNION
SELECT business
FROM services 
WHERE feature = 'BusinessParking_valet';

-- estrarre gli amici comuni a Anita e Susan
with susan_friends as (
SELECT reviewer_a as friend
FROM friend INNER JOIN reviewer ON reviewer_b = reviewer.id 
WHERE name = 'Susan'
UNION
SELECT reviewer_b as friend
FROM friend INNER JOIN reviewer ON reviewer_a = reviewer.id 
WHERE name = 'Susan'),
anita_friends as (
SELECT reviewer_a as friend
FROM friend INNER JOIN reviewer ON reviewer_b = reviewer.id 
WHERE name = 'Anita'
UNION
SELECT reviewer_b as friend
FROM friend INNER JOIN reviewer ON reviewer_a = reviewer.id 
WHERE name = 'Anita')
SELECT friend
FROM susan_friends
INTERSECT 
SELECT friend
FROM anita_friends;

-- estrarre le attività recensite da Alien che non sono recensite da Susan
with alien_reviews as (
    SELECT business
    FROM review INNER JOIN reviewer ON reviewer.id = review.reviewer
    WHERE name = 'Alien'),
    susan_reviews as (
    SELECT business
    FROM review INNER JOIN reviewer ON reviewer.id = review.reviewer
    WHERE name = 'Susan')
    SELECT business
    FROM alien_reviews
    EXCEPT
    select business
    FROM susan_reviews;

-- estrarre il nome dei revisori che non hanno effettuato alcuna recensione
SELECT id, name
FROM reviewer LEFT JOIN review ON reviewer.id = review.reviewer
WHERE review.reviewer IS NULL;

-- estrarre il nome dei revisori con più fan del revisore Alien
-- soluzione 1: usare query nidificata 
-- la query nidificata può restituire più valori
-- si può usare max/min nella query nidificata per restituire un unico valore da confrontare
-- oppure si può usare l'operatore ALL/ANY
-- https://www.postgresql.org/docs/current/functions-comparisons.html#FUNCTIONS-COMPARISONS-ALL
SELECT id, name
FROM reviewer
WHERE fans > ALL (
    SELECT fans
    FROM reviewer
    WHERE name = 'Alien');

-- soluzione 2: usare join
SELECT r1.id, r1.name
FROM reviewer r1 INNER JOIN reviewer r2 ON r1.fans > r2.fans
WHERE r2.name = 'Alien';