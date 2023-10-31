-- estrarre il numero di business di Pizza Hut
SELECT count(*)
FROM business
WHERE name = 'Pizza Hut';

-- estrarre il numero complessivo di recensioni ricevute da tutti i Pizza Hut
SELECT count(*)
FROM business INNER JOIN review ON business.id = review.business
WHERE name = 'Pizza Hut';

-- estrarre il numero medio di stelle di tutti i Pizza Hut
SELECT avg(review.stars)
FROM business INNER JOIN review ON business.id = review.business
WHERE name = 'Pizza Hut';

-- estrarre il numero complessivo di categorie disponibili
select count(*)
FROM category;

-- estrarre il numero complessivo di opinioni cool rispetto alle recensioni di Susan 
SELECT sum(review.cool)
FROM reviewer INNER JOIN review ON reviewer.id = review.reviewer
WHERE name = 'Susan';

-- estrarre il numero di categorie usate da almeno un business
SELECT count(distinct category)
FROM incat;

-- per ogni business, estrarre il numero di recensioni e il numero massimo di stelle ricevute in una review
SELECT business, count(*), max(stars)
FROM review 
GROUP BY business;

-- per ogni business di categoria "food", estrarre il numero di recensioni ricevute (considerando anche i business privi di recensioni)
WITH food_business AS (
    SELECT business
    FROM incat
    WHERE category = 'food')
SELECT business.id, count(review.business)
FROM food_business LEFT JOIN review ON food_business.business = review.business;

-- per ogni business di categoria "food", estrarre il numero di recensioni con meno di 3 stelle 
WITH food_business AS (
    SELECT business
    FROM incat
    WHERE category = 'food')
SELECT business.id, count(review.business)
FROM food_business LEFT JOIN review ON food_business.business = review.business
WHERE stars < 3;

-- per ogni categoria, estrarre il numero di business associati 
SELECT id, count(business)
FROM category LEFT JOIN incat ON category.id = incat.category;

-- estrarre il business con più di 5 servizi offerti 
SELECT business
FROM services
GROUP BY business
HAVING count(*) > 5;

-- estrarre i nomi dei revisori che sono univoci 
SELECT name
FROM reviewer
GROUP BY name
HAVING count(*) = 1;

-- estrarre il nome e la media delle stelle ricevute da business nella categoria food che offrono almeno 5 servizi
WITH food_business AS (
    SELECT business
    FROM incat 
    WHERE category = 'food'),
    over_5 AS (
        SELECT business
        FROM services INNER JOIN food_business ON services.business = food_business.business
        GROUP BY business
        HAVING count(*) >= 5)
        SELECT id, name, AVG(review.stars)
        FROM business INNER JOIN over_5 ON business.id = over_5.business INNER JOIN review ON business.id = review.business
        GROUP BY business.id, business.name;


