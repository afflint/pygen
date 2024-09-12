-- comandi di interrogazione in SQL: SELECT

-- trovare la posizione delle attività commerciali di nome starbucks
SELECT id, name, city, stars, review_count
FROM business 
WHERE name = 'Starbucks'

-- trovare la posizione delle attività commerciali di nome starbucks che risultano attive
SELECT id, name, city, stars, review_count, is_active 
FROM business 
WHERE name = 'Starbucks' and is_active = 1

-- la medesima query con approssimazione nel confronto con il nome
-- like: operatore per confrontare due stringhe di testo in modo approssimato. Sono previsti due segnaposto
--- %: indica una stringa di qualsiasi lunghezza
--- _: indica un singolo carattere
-- si possono anche utilizzare le funzioni UPPER/LOWER che alzano/abbassano il case del carattere
SELECT id as identificatore, name as nome, UPPER(name) as "nome maiuscolo", LOWER(name) as minuscolo, city, stars, review_count, is_active 
FROM business 
WHERE lower(name) like '%starbucks%' and is_active = 1

-- la medesima con burger
SELECT id, name, city, stars, review_count, is_active 
FROM business 
WHERE name like '%burger%' and is_active = 1

-- cerco burger come prima parola del nome
SELECT id, name, city, stars, review_count, is_active 
FROM business 
WHERE name like 'burger%' and is_active = 1

-- cerco burger come ultima parola del nome
SELECT id, name, city, stars, review_count, is_active 
FROM business 
WHERE name like '%burger' and is_active = 1

-- cerco burger come ultima parola isolata del nome 
SELECT id, name, city, stars, review_count, is_active 
FROM business 
WHERE name like '% burger' and is_active = 1

-- cerco i nomi con tarbucks preceduto da una qualsiasi lettera
SELECT id, name, city, stars, review_count, is_active 
FROM business 
WHERE name like '_tarbucks' and is_active = 1

-- restituire le review che hanno almeno 3 stelle e che sono utili ad almeno 5 utenti
SELECT *
from review
where stars >= 3 and useful >= 5

-- restituire le review con numero di stelle diverso da 5 oppure uguale a 5 con almeno 10 utenti che la ritengono utile
SELECT *
from review
where stars <> 5 OR (stars = 5 and useful >= 10)

-- restituire le attività commerciali che operano in una delle seguenti città 
-- 0718B3
-- A230B3
-- D911D9
-- 62E236
-- 647C3A
-- EB19A6
select *
from business 
where city = '0718B3' or city = 'A230B3' or city = 'D911D9' ...

-- soluzione alternativa
select *
from business 
where city in ('0718B3', 'A230B3', 'D911D9', '62E236', '647C3A', 'EB19A6')

-- restituire le attività commerciali che operano in una delle città dello stato di Ontario (OH)
-- usiamo una sottoquery/subquery o query nidificata o query innestata
select *
from business 
where city in 
(select id 
from city 
where country = 'OH')

-- città dello stato di Ontario (OH)
select * 
from city 
where country = 'OH'

-- salviamo la query come vista 
create view business_ontario as 
select *
from business 
where city in 
(select id 
from city 
where country = 'OH')

-- la vista è una materializzazione della query e può essere usata come una tabella cioè posso vederne il contenuto e posso usarla come tabella nella clausola from di un'altra query
select * 
from business_ontario 

-- restituisci solo id e nome delle business_ontario attive
select id, name
from business_ontario 
where is_active = 1

-- la vista NON memorizza dati quindi la vista è sempre aggiornata rispetto al contenuto delle tabelle

-- se voglio archiviare il risultato di una query nel database (cioè i dati)
-- creo una tabella 
create table business_ontario_20240912 as 
select *
from business 
where city in 
(select id 
from city 
where country = 'OH')


-- vediamo la stessa query usando il join
-- partiamo dal concetto di prodotto cartesiano:
-- è la combinazione di ciascun record di business con ciascun record di city
select *
from business, city 

-- l'operazione di join è un'operazione di filtro sul prodotto cartesiano
select business.*
from business, city 
where business.city = city.id and city.country = 'OH'

-- sintassi alternativa
select business.*
from business inner join city on business.city = city.id
where city.country = 'OH'

-- restituire le stelle di ciascuna review per ogni starbucks
-- limitiamo il risultato alle review con almeno 3 stelle
-- voglio vedere nel risulato anche il nome del reviewer
select business.id, business.name, review.business, review.stars, review.reviewer, reviewer.id, reviewer.name 
from review inner join business on business.id = review.business inner join reviewer on reviewer.id = review.reviewer
where lower(business.name) = 'starbucks' and review.stars >= 3
order by id 

