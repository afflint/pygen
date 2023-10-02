-- restituire i servizi (tabella services) offerti dalle aziende attive che hanno almeno 4 stelle (business.stars >=4) 
SELECT id, name, is_active, stars, business, feature
FROM business, services
WHERE business.id = services.business AND business.stars >=4 AND business.is_active = true
ORDER BY id;

SELECT id, name, is_active, stars, business, feature
FROM business INNER JOIN services ON business.id = services.business
WHERE business.stars >=4 AND business.is_active = true
ORDER BY id;

-- restituire il nome delle persone che sono amiche (tabella friend)
-- suggerimento: la tabella reviewer deve comparire due volte nel join (serve un alias di relazione)
SELECT r1.id as persona, r1.name as "nome persona", r2.id as amico, r2.name as "nome amico"
FROM reviewer r1 INNER JOIN friend ON r1.id = friend.reviewer_a INNER JOIN reviewer r2 ON r2.id = friend.reviewer_b;


-- estrarre quelle aziende che non hanno servizi associati
-- operazione di join laterale/esterno: LEFT OUTER, RIGHT OUTER
-- LEFT JOIN: corrisponde al JOIN INTERNO (INNER JOIN) + record della tabella di sinistra che non hanno corrispondenze nella tabella di destra
-- 58.884
SELECT id, name
FROM business LEFT OUTER JOIN services ON business.id = services.business
WHERE services.business IS NULL;

SELECT name, id, services.*
FROM services RIGHT OUTER JOIN business ON business.id = services.business
WHERE services.business IS NULL;

-- soluzione alternativa con operatori insiemistici
-- le aziende che non offrono servizi sono quelle che risultano dalla differenza tra business e services
SELECT id
FROM business
EXCEPT
SELECT distinct business
FROM services

-- come faccio a mostrare anche il nome del business nel risultato
-- EXCEPT richiede che lo schema delle due query sia compatibile
SELECT id, name
FROM business
EXCEPT
SELECT distinct services.business, name
FROM services INNER JOIN business ON services.business = business.id

-- oltre a LEFT e RIGHT esiste FULL che equivale a LEFT+RIGHT

-- mostrare le categorie che non sono mai associate a business (category/incat)
SELECT category.name, incat.*
FROM incat RIGHT JOIN category ON incat.category = category.name
WHERE incat.category IS NULL;

-- con operatore insiemistico
SELECT name
FROM category 
EXCEPT
SELECT distinct category
FROM incat;


-- estrarre i nominativi dei revisori che non hanno amici (reviewer_a)
-- friend.reviewer_a -> reviewer.id
SELECT id, name, friend.*
FROM friend RIGHT JOIN reviewer ON friend.reviewer_a = reviewer.id
WHERE friend.reviewer_a IS NULL

-- estrarre i nominativi dei revisori che non hanno amici (reviewer_a e reviewer_b)
-- questa operazione restituisce i revisori che non hanno corrispondenza su reviewer_a oppure non hanno corrispondenza su reviewer_b: non è il risultato desiderato, noi vogliamo quei reviewer che non hanno corrispondenza sia su reviewer_a sia su reviewer_b
SELECT r1.id, r1.name, friend.*, r2.id, r2.name
FROM friend RIGHT JOIN reviewer r1 ON friend.reviewer_a = r1.id 
RIGHT JOIN reviewer r2 ON friend.reviewer_b = r2.id
WHERE friend.reviewer_a IS NULL AND friend.reviewer_b IS NULL;

-- soluzione: fare due query (una per reviewer_a e una per reviewer_b) e mettere in inner join le due query


-- una soluzione alternativa è usare gli operatori insiemistici
-- cerchiamo quei reviewer che non hanno corrispondenza su reviewer_a e non hanno corrispondenza su reviewer_b (intersezione)
-- mancata corrispondenza su reviewer_a
SELECT id, name
FROM friend RIGHT JOIN reviewer ON friend.reviewer_a = reviewer.id
WHERE friend.reviewer_a IS NULL

-- mancata corrispondenza su reviewer_b
SELECT id, name
FROM friend RIGHT JOIN reviewer ON friend.reviewer_b = reviewer.id
WHERE friend.reviewer_b IS NULL

-- intersezione
SELECT id, name
FROM friend RIGHT JOIN reviewer ON friend.reviewer_a = reviewer.id
WHERE friend.reviewer_a IS NULL
INTERSECT
SELECT id, name
FROM friend RIGHT JOIN reviewer ON friend.reviewer_b = reviewer.id
WHERE friend.reviewer_b IS NULL;


-- trovare quelle catene di attività (business.name) che hanno sedi sia in Nevada (NV) sia in Arizona (AZ)
-- aziende in Nevada
SELECT distinct business.name
FROM business INNER JOIN city ON business.city = city.id
WHERE country = 'NV';

-- aziende in Arizona
SELECT distinct business.name
FROM business INNER JOIN city ON business.city = city.id
WHERE country = 'AZ';

-- sia Nevada sia Arizona
-- 1.364 risultati
SELECT distinct business.name
FROM business INNER JOIN city ON business.city = city.id
WHERE country = 'NV'
INTERSECT 
SELECT distinct business.name
FROM business INNER JOIN city ON business.city = city.id
WHERE country = 'AZ';

-- versione alternativa con subquery, query nidificata, sottoquery, nested query
SELECT distinct business.name
FROM business INNER JOIN city ON business.city = city.id
WHERE country = 'NV' AND business.name IN (
SELECT distinct business.name
FROM business INNER JOIN city ON business.city = city.id
WHERE country = 'AZ');

-- questa soluzione NON è equivalente
-- questa da sempre insieme vuoto come risultato
SELECT distinct business.name
FROM business INNER JOIN city ON business.city = city.id
WHERE country = 'NV' AND country = 'AZ';

-- questa è una soluzione alternativa con INNER JOIN
SELECT distinct b1.name
FROM (business b1 INNER JOIN city c1 ON b1.city = c1.id) INNER JOIN (business b2 INNER JOIN city c2 ON b2.city = c2.id) 
ON b1.name = b2.name
WHERE c1.country = 'NV' AND c2.country = 'AZ';

-- altra sintassi
-- CTE (Common Table Expression)
WITH business_nevada AS (
SELECT distinct business.name
FROM business INNER JOIN city ON business.city = city.id
WHERE country = 'NV'),
business_arizona AS (
SELECT distinct business.name
FROM business INNER JOIN city ON business.city = city.id
WHERE country = 'AZ')
SELECT bn.name
FROM business_nevada bn INNER JOIN business_arizona ba ON bn.name = ba.name;


-- restituire le aziende che sono di categoria Restaurants oppure Seafood
-- UNION ALL restituisce i duplicati (cioè le aziende che sono sia Restaurants sia Seafood)
SELECT business
FROM incat
WHERE category = 'Restaurants'
UNION  
SELECT business
FROM incat
WHERE category = 'Seafood';

-- (UNION ALL) EXCEPT (UNION) = INTERSECT

-- questa è equivalente a
SELECT business
FROM incat
WHERE category = 'Restaurants' OR category = 'Seafood';

SELECT business
FROM incat
WHERE category IN ('Restaurants', 'Seafood');


-- estrarre il nome dei revisori che non hanno mai fatto review con più di 4 stelle 


-- trovo il numero di stelle massimo per ogni revisore e vedo quello che non è mai andato oltre il 4
-- richiede di utilizzare i raggruppamenti e gli operatori aggregati (max)


-- costruisco il join fra reviewer e review prendendo le review con punteggio superiore a 4. Devo restituire il complemento (revisori che non stanno nel join)
-- operatori insiemistici: dall'insieme di tutti i reviewer tolgo (EXCEPT) i reviewer in review che hanno dato >4 stelle
-- A - B
-- risultati: 434.598
-- A: tutti i reviewer
SELECT id, name
FROM reviewer
EXCEPT
-- B: query che restituisce il codice dei reviewer che hanno dato più di 4 stelle
SELECT distinct id, name
FROM reviewer INNER JOIN review ON review.reviewer = reviewer.id
WHERE review.stars > 4 

-- alternativa
WITH reviewer_severo AS (
SELECT id
FROM reviewer 
EXCEPT
SELECT distinct reviewer
FROM review 
WHERE stars > 4)
SELECT r.id, name
FROM reviewer r INNER JOIN reviewer_severo rs ON r.id = rs.id;

-- faccio il join fra reviewer e review considerando le stelle sopra 4 e prendo solo i reviewer che non stanno nel join
-- join che considera i record "spuri": left join
WITH reviewer_severo AS (
SELECT distinct reviewer
FROM review 
WHERE stars > 4)
SELECT r.id, r.name
FROM reviewer r LEFT JOIN reviewer_severo rs ON r.id = rs.reviewer
WHERE rs.reviewer IS NULL;

-- variante con left join ma sbagliata
SELECT r.id, r.name
FROM reviewer r LEFT JOIN review rs ON r.id = rs.reviewer
WHERE rs.stars > 4 AND rs.reviewer IS NULL;


-- variante con left join giusta
SELECT r.id, r.name
FROM reviewer r LEFT JOIN review rs ON (r.id = rs.reviewer AND rs.stars > 4)
WHERE rs.reviewer IS NULL;


-- query1: prendo le review con più di 4 stelle e estraggo i revisori. Query2: restituisco i reviewer che non stanno nel risultato di query1
SELECT id, name
FROM reviewer r 
WHERE id NOT IN (
SELECT distinct reviewer
FROM review 
WHERE stars > 4);


-- query con raggruppamento (GROUP BY)
-- operatori aggregati
-- max
-- min
-- avg
-- sum
-- count

-- query correlate
-- ??