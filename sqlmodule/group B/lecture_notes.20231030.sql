SELECT b.id, s.*
FROM services s LEFT JOIN business b ON (b.id = s.business)
WHERE s.business IS NULL

SELECT b.id, s.*
FROM services s LEFT JOIN business b ON (b.id = s.business AND s.business IS NULL)

-- estrarre il nome dei revisori che non hanno effettuato alcuna recensione
SELECT reviewer.id, reviewer.name
FROM reviewer LEFT JOIN review on reviewer.id =review.reviewer
WHERE review.reviewer is null;

with reviewer_join as (
SELECT reviewer.id, reviewer.name, review.reviewer
FROM reviewer LEFT JOIN review on reviewer.id = review.reviewer)
select id, name from reviewer_join WHERE reviewer is null;

-- query con aggregazione

-- operatori/funzioni aggregati
-- sum()
-- max()
-- min()
-- avg()
-- count(*), coount(<attributo>), count(distinct <attributo>) 

-- quale è la valutazione massima/minima/media ricevuta da aziende di Las Vegas
with business_las_vegas as (
SELECT business.id 
from business inner join city on business.city = city.id 
where city.name ='Las Vegas' and country = 'NV'),
review_business_las_vegas as (
SELECT stars 
FROM review INNER JOIN business_las_vegas ON review.business = business_las_vegas.id)
SELECT MAX(stars) as "valutazione massima aziende las vegas", MIN(stars) as "valutazione minima aziende las vegas", AVG(stars) as "valutazione media aziende las vegas"
FROM review_business_las_vegas;

-- quale è la valutazione minima data a un'azienda da un qualsiasi reviewer di nome Bob
SELECT MIN(stars)
FROM reviewer INNER JOIN review ON reviewer.id = review.reviewer 
WHERE name = 'Bob';

-- quale è la valutazione minima/massima/media data a un'azienda da ciascun reviewer di nome Bob. Mostrare nel risultato anche la numerosità delle review svolte da ciascun reviewer
-- includere anche i reviewer di nome Bob che non hanno mai svolto alcuna review
-- count(*) conta i record in un gruppo
-- count(<attributo>) conta i valori sull'attributo
SELECT reviewer.id, MIN(stars), MAX(stars), AVG(stars), count(*), count(review.reviewer)
FROM reviewer LEFT JOIN review ON reviewer.id = review.reviewer 
WHERE name = 'Bob' 
-- AND reviewer.id = '9IKSftz9D5INprPIeAldRw'
GROUP BY reviewer.id;

-- vado a cercare un utente Bob che non ha svolto review
-- trovo i reviewer Bob che non hanno fatto review
SELECT id 
FROM reviewer LEFT JOIN review ON reviewer.id = review.reviewer
WHERE name = 'Bob' AND review.reviewer IS NULL;

-- quanti sono gli utenti di nome Bob?
SELECT count(*), count(id), count(distinct id) 
FROM reviewer r 
WHERE r.name = 'Bob';

-- quale è la media delle valutazioni delle aziende Starbucks

-- estrarre il numero di recensioni complessivamente ricevute da tutti i Pizza Hut
SELECT count(*)
FROM review INNER JOIN business ON review.business = business.id 
WHERE name = 'Pizza Hut';

-- estrarre il numero di recensioni ricevute da ciascun Pizza Hut
-- incluse le aziende che non hanno recensioni
SELECT id, count(*), count(review.business)
FROM review RIGHT JOIN business ON review.business = business.id 
WHERE name = 'Pizza Hut'
GROUP BY business.id;

-- estrarre il numero di recensioni ricevute da ciascun Pizza Hut
-- mostrando soltanto quelle che hanno 1 
SELECT id, count(*), count(review.business)
FROM review RIGHT JOIN business ON review.business = business.id 
WHERE name = 'Pizza Hut'
GROUP BY business.id
HAVING count(review.business) = 1 ;

-- estrarre il numero di recensioni ricevute da ciascun Pizza Hut
-- mostrando soltanto quelle che hanno almeno 10 recensioni
SELECT id, count(*), count(review.business)
FROM review RIGHT JOIN business ON review.business = business.id 
WHERE name = 'Pizza Hut'
GROUP BY business.id
HAVING count(review.business) > 10;

-- estrarre il nome dei revisori che hanno eseguito almeno 50 review
-- quando si usa una group by è possibile proiettare nella select solo attributi che fanno parte del raggruppamento oppure funzioni aggregate
SELECT id, name, count(*)
FROM review INNER JOIN reviewer ON review.reviewer = reviewer.id
GROUP BY reviewer.id, name
HAVING count(*) >= 50
ORDER BY 1,2;

-- estrarre il nome dei revisori che hanno eseguito almeno 50 review di aziende diverse
SELECT id, name, count(*), count(distinct review.business)
FROM review INNER JOIN reviewer ON review.reviewer = reviewer.id
GROUP BY reviewer.id, name
HAVING count(distinct review.business) >= 50
ORDER BY 1,2;

-- estrarre il nome dei revisori che hanno eseguito almeno 50 review di aziende diverse ma almeno una volta hanno valutato la stessa azienda
SELECT id, name, count(*), count(distinct review.business)
FROM review INNER JOIN reviewer ON review.reviewer = reviewer.id
GROUP BY reviewer.id, name
HAVING count(distinct review.business) >= 50 
	AND count(*) <> count(distinct review.business)
ORDER BY 1,2;


-- mostrare l'id e il nome delle aziende che sono valutate più di una volta dal medesimo reviewer
SELECT business, business.name, reviewer, reviewer.name, count(*)
FROM review INNER JOIN reviewer ON review.reviewer = reviewer.id INNER JOIN business ON review.business = business.id
GROUP BY review.reviewer, reviewer.name, review.business, business.name
HAVING count(*) > 1;

-- altra soluzione con join 
-- cerco due record di review che abbiano lo stesso revisore, la stessa azienda, ma siano due review diverse
SELECT distinct r1.reviewer, reviewer.name, r1.business, business.name
FROM review r1, review r2, reviewer, business 
WHERE r1.business = r2.business AND r1.reviewer = r2.reviewer AND r1.review_date <> r2.review_date AND r1.business = business.id AND r1.reviewer = reviewer.id;


--* estrarre il nome dei revisori che hanno eseguito più di 10 review con almeno 3 stelle
SELECT id, name, count(*)
FROM review INNER JOIN reviewer ON review.reviewer = reviewer.id
WHERE stars >= 3
GROUP BY reviewer.id, name
HAVING count(*) > 10;

--* estrarre il nome dei revisori che hanno eseguito più di 10 review con una media di almeno 3 stelle
SELECT id, name, count(*), avg(stars)
FROM review INNER JOIN reviewer ON review.reviewer = reviewer.id
GROUP BY reviewer.id, name
HAVING count(*) > 10 AND avg(stars) >= 3;


-- estrarre le aziende che hanno almeno una delle categorie degli Starbucks di Las Vegas e un valore di business.stars > media delle stars di tutti gli starbucks_las_vegas
-- trovare gli Starbucks di Las Vegas
with starbucks_las_vegas as (
SELECT business.id
FROM business INNER JOIN city ON business.city = city.id 
WHERE business.name = 'Starbucks' AND city.name = 'Las Vegas' AND country = 'NV'),
-- categorie degli Starbucks di Las Vegas
category_starbucks as (
SELECT distinct category
FROM incat INNER JOIN starbucks_las_vegas ON incat.business = starbucks_las_vegas.id),
-- media delle valutazioni degli Starbucks di Las Vegas
avg_starbucks as (
SELECT avg(stars) as avg_stars
FROM review INNER JOIN starbucks_las_vegas ON review.business = starbucks_las_vegas.id),
-- aziende con almeno una categoria comune agli Starbucks di Las Vegas
business_common_category as (
SELECT distinct business
FROM incat INNER JOIN category_starbucks ON incat.category = category_starbucks.category)
-- trovare le aziende di business_common_category che hanno media stars > avg_starbucks
SELECT business
FROM business INNER JOIN business_common_category ON business.id = business_common_category.business
WHERE business.stars > (SELECT avg_stars FROM avg_starbucks);

-- alternativa alla query principale precedente
SELECT business
FROM business INNER JOIN business_common_category ON business.id = business_common_category.business INNER JOIN avg_starbucks ON business.stars > avg_starbucks.avg_stars;

incat:
-- b1 - c1 -> join con c1 di category_starbucks
-- b1 - c2 -> join con c2 di category_starbucks
-- b1 - c3 -> nessun join

category_starbucks:
-- c1
-- c2


-- restituire il nome del revisore che ha eseguito il maggior numero di recensioni
-- soluzione intuitiva, ma errata è la seguente:
SELECT max(count(*))
FROM review 
GROUP BY reviewer;

-- conto le review di ciascun reviewer
WITH count_review AS (
SELECT reviewer, count(*) as r_count
FROM review 
GROUP BY reviewer),
-- trovo il valore massimo
max_count as (
SELECT max(r_count) as r_max
FROM count_review)
-- restituisco il reviewer che ha il valore massimo
SELECT id, name, r_count
FROM reviewer INNER JOIN count_review ON reviewer.id = count_review.reviewer
WHERE r_count = (SELECT r_max FROM max_count);


-- sintassi alternativa per la query principale della precedente
SELECT id, name, r_count
FROM reviewer INNER JOIN count_review ON reviewer.id = count_review.reviewer INNER JOIN max_count ON r_count = max_count.r_max;


