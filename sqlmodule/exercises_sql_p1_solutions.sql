-- restituire il nome delle aziende per le quali non sono note latitudine e longitudine
SELECT id, name FROM business WHERE lat IS NULL and lon IS NULL;

-- restituire il paese in cui sono presenti attività che si occupano di audio (la parola audio è nel nome dell'attività)
SELECT country
FROM business INNER JOIN city ON business.city = city.id 
WHERE name LIKE '%audio%';

-- restituire il nome dei revisori che hanno fatto almeno una review con 5 stelle
SELECT distinct id, name
FROM reviewer INNER JOIN review ON reviewer.id = review.reviewer
WHERE stars = 5;

-- restituire il nome dei revisori che hanno fatto review trovate utili da almeno 10 utenti (review.useful >= 10)
SELECT distinct id, name 
FROM reviewer INNER JOIN review ON reviewer.id = review.reviewer
WHERE review.useful >= 10;

-- per le review con stelle comprese nell'intervallo 2-3, restituire il nome del reviewer e il nome dell'azienda recensita 
SELECT distinct reviewer.id, reviewer.name, business.id, business.name, review.stars
FROM reviewer INNER JOIN review ON reviewer.id = review.reviewer INNER JOIN business ON business.id = review.business
WHERE review.stars BETWEEN 2 AND 3;

-- restituire i servizi (tabella services) offerti dalle aziende attive che hanno almeno 4 stelle (business.stars >=4) 
SELECT distinct feature
FROM business INNER JOIN services ON business.id = services.business
WHERE is_active = true AND stars >= 4;

-- restituire i servizi offerti dalle aziende di categoria (tabella incat) "Restaurants"	
SELECT distinct feature
FROM business INNER JOIN incat ON business.id = incat.business INNER JOIN services ON business.id = services.business
WHERE incat.category = 'Restaurants';

-- restituire il nome delle persone che sono amiche (tabella friend)
-- suggerimento: la tabella reviewer deve comparire due volte nel join (serve un alias di relazione)
SELECT r1.id AS "id persona", r1.name AS persona, r2.id AS "id amico", r2.name AS amico
FROM reviewer r1 INNER JOIN friend ON r1.id = reviewer_a INNER JOIN reviewer r2 ON r2.id = reviewer_b;