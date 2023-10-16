-- SQL (Structured Query Language): linguaggio standard per manipolare e interrogare un database relazionale

-- query/interrogazione: un'operazione di estrazione dati dal db
-- il seguente comando restituisce il contenuto della tabella business
SELECT *
FROM business;

-- estrarre il nome delle attività commerciali con almeno 4 stelle
SELECT id, name, stars
FROM business
WHERE stars >= 4;

-- è possibile memorizzare in un db un comando SELECT mediante la creazione di una vista
-- la vista NON costituisce una materializzazione del risultato della query
-- la query sottostante crea una vista che viene eseguita nel momento in cui si invoca la vista
CREATE VIEW business_4_stars as (
SELECT id, name, stars
FROM business
WHERE stars >= 4);

SELECT id, name
FROM business_4_stars;

-- soluzione diversa: creo una tabella temporanea la cui struttura e contenuto corrisponde al risultato di una query
-- il contenuto della tabella temporanea NON è aggiornato rispetto alla tabella business
-- ulteriore oggetto da indagare sul tema della materializzazione dei risultati di una query: MATERIALIZED VIEW
CREATE [TEMPORARY] TABLE business_temp_4_stars AS 
(SELECT id, name, stars
FROM business
WHERE stars >= 4);

-- estrarre il nome delle attività che hanno almeno 4 stelle e almeno 10 review
-- operatori booleani: AND/OR/NOT
SELECT id, name
FROM business
WHERE stars >= 4 AND review_count >= 10;

-- estrarre id, name delle attività che hanno stelle comprese fra 3 e 4 (estremi inclusi) oppure numero di recensioni compreso fra 10 e 20 (estremi esclusi)
-- la precedenza degli operatori booleani nella clausola WHERE va da sinistra a destra
SELECT id, name, stars, review_count
FROM business
WHERE (stars >= 3 AND stars <= 4) OR (review_count > 10 AND review_count < 20);
-- WHERE 3 <= stars <= 4 OR 10 < review_count < 20;
-- WHERE stars between 3 AND 4 OR 10 < review_count < 20;

-- trovare le attività per le quali non è noto il quartiere
SELECT id, name, neighborhood
FROM business
WHERE neighborhood is NULL;
-- diverso da
SELECT id, name, neighborhood
FROM business
WHERE neighborhood = '';

SELECT id, name, neighborhood
FROM business
WHERE neighborhood = 'NULL';


-- trovare le attività per le quali  è noto il quartiere
SELECT id, name, neighborhood
FROM business
WHERE neighborhood is NOT NULL;

-- trovare le attività che si occupano di pizza (nel nome compare il termine pizza)
-- like: confronto approssimato di strighe 
-- wildcard/segnaposto
-- %: sostituisce una stringa di qualsiasi lunghezza
-- _: sostituisce una stringa di una carattere di lunghezza
SELECT id, name, neighborhood
FROM business
WHERE name LIKE '%pizza%';


-- analoga ma con pizza all'inizio del nome
SELECT id, name, neighborhood
FROM business
WHERE name LIKE 'pizza%';

-- analoga ma con pizza in coda al nome
SELECT id, name, neighborhood
FROM business
WHERE name LIKE '%pizza';

-- attenzione al case (maiuscole/minuscole)
-- SQLite, MySQL è case insensitive: like restituisce i record con pizza scritto maiusscolo o minuscolo
-- Oracle, PostgreSQL: like è case sensitive. In questo caso bisogna usare funzioni del DBMS per normalizzare il case
SELECT id, name, neighborhood
FROM business
WHERE LOWER(name) LIKE '%pizza';


-- operazioni di join
-- estrarre le categorie delle attività di business a las vegas (Nevada)


-- arriviamo al risultato per passi
-- quali sono le città delle attività commerciali
SELECT *
FROM business, city 
WHERE business.city = city.id;

SELECT *
FROM business INNER JOIN city ON business.city = city.id;

SELECT *
FROM business, city 
WHERE business.city = city.id AND city.name = 'Las Vegas' AND country = 'NV';

SELECT business.id, business.name 
FROM business INNER JOIN city ON business.city = city.id
WHERE city.name = 'Las Vegas' AND country = 'NV';


-- quali sono le categorie delle attività commerciali
SELECT *
FROM business INNER JOIN incat ON incat.business = business.id
ORDER BY business.name

-- troviamo le attività commerciali di Las Vegas e restituiamo le categorie
SELECT distinct incat.category
FROM business INNER JOIN city ON business.city = city.id INNER JOIN incat ON incat.business = business.id
WHERE city.name = 'Las Vegas' AND country = 'NV';

-- mostrare il nome dei recensori delle attività di Pizza Hut
SELECT DISTINCT reviewer.id, reviewer.name
FROM business INNER JOIN review ON business.id = review.business INNER JOIN reviewer ON review.reviewer = reviewer.id
WHERE business.name LIKE '%Pizza Hut%'
ORDER BY reviewer.name;

-- estrarre il nome dei revisori che non hanno mai fatto review con più di 4 stelle 

-- trovo il numero di stelle massimo per ogni revisore e vedo quello che non è mai andato oltre il 4
-- richiede di utilizzare i raggruppamenti e gli operatori aggregati (max)

-- costruisco il join fra reviewer e review prendendo le review con punteggio superiore a 4. Devo restituire il complemento (revisori che non stanno nel join)
-- operatori insiemistici

-- faccio il join fra reviewer e review considerando le stelle sopra 4 e prendo solo i reviewer che non stanno nel join
-- join che considera i record "spuri": left join

-- query1: prendo le review con più di 4 stelle e estraggo i revisori. Query2: restituisco i reviewer che non stanno nel risultato di query1







