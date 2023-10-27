-- viste: è una query salvata per scopi futuri
-- restituire i servizi delle aziende con almeno 4 stelle
-- condizioni di selezione
-- operazioni di join
SELECT distinct business.id, name, feature as "business service"
FROM business INNER JOIN services ON business.id = services.business 
WHERE stars >= 4
ORDER BY name, feature;

CREATE view business_with_services AS 
SELECT distinct business.id, name, feature as "business service"
FROM business INNER JOIN services ON business.id = services.business 
WHERE stars >= 4
ORDER BY name, feature;

-- come osservo il contenuto della vista?
SELECT *
FROM business_with_services;

-- business che offrono il servizio di HappyHour
select id, name
from business_with_services
where "business service" = 'HappyHour';

-- restituire i servizi delle aziende di las vegas (aziende con almeno 4 stelle)
SELECT distinct "business service"
FROM business_with_services bws INNER JOIN business b ON bws.id = b.id INNER JOIN city c ON b.city = c.id 
WHERE c.name = 'Las Vegas' AND country = 'NV';

-- restituire il nome delle persone che sono amiche (tabella friend)
SELECT friend.*, ra.id, ra.name as "reviewer A", rb.id, rb.name as "reviewer B"
FROM friend INNER JOIN reviewer ra ON friend.reviewer_a = ra.id INNER JOIN reviewer rb ON friend.reviewer_b = rb.id;

-- mostrare le categorie e i servizi di ciascuna azienda
SELECT 
FROM business b INNER JOIN incat i ON b.id = i.business INNER JOIN services s ON b.id = s.business

-- estrarre quelle aziende che non hanno servizi associati

-- join laterale
-- LEFT JOIN: è un join interno (inner) a cui si aggingono i record "spuri" della tabella di sinistra nel join
SELECT b.id, b.name, s.*
FROM business b LEFT JOIN services s ON b.id = s.business 
WHERE s.business IS NULL; 

-- double check sui risultati
select count(b.id)
  from business b LEFT JOIN services s ON b.id = s.business
   where s.business is null
  union all
  select count(b.id)
   from business b LEFT JOIN services s ON (b.id = s.business and s.business is null)
   
select count(b.id)
from business b INNER  JOIN services s ON b.id = s.business 
   

-- equivalente alla precedente
SELECT b.id, b.name, s.*
FROM business b LEFT JOIN services s ON b.id = s.business AND s.business IS NULL; 

-- equivalente alla precedente
-- RIGHT JOIN: è un join interno (inner) a cui si aggingono i record "spuri" della tabella di destra nel join
SELECT b.id, s.*
FROM services s RIGHT JOIN business b ON (b.id = s.business)
WHERE s.business IS NULL

-- join laterali/esterni
-- FULL [OUTER] JOIN: INNER + LEFT + RIGHT
SELECT b.id, s.*
FROM services s FULL OUTER JOIN business b ON b.id = s.business
ORDER BY s.business 

-- consideriamo il seguente caso
SELECT b.id, s.*
FROM services s LEFT JOIN business b ON (b.id = s.business)
WHERE s.business IS NULL

-- diverso risultato se 
-- spiegazione:
-- https://www.postgresql.org/docs/current/queries-table-expressions.html
-- LEFT JOIN: First, an inner join is performed. Then, for each row in T1 that does not satisfy the join condition with any row in T2, a joined row is added with null values in columns of T2. Thus, the joined table always has at least one row for each row in T1.
SELECT b.id, s.*
FROM services s LEFT JOIN business b ON (b.id = s.business AND s.business IS NULL)


-- operazioni insiemistiche 
-- è la differenza fra l'insieme delle aziende in business (A) e l'insieme delle aziende in services (B)
-- EXCEPT: operatore insiemistico di sottrazione
SELECT id 
FROM business b 
EXCEPT
select distinct business
FROM services;


-- subquery / nested query
SELECT id 
from business b
where b.id NOT IN (
SELECT distinct business
FROM services);

select count(distinct business)
from services

-- estrarre le aziende che hanno almeno due servizi offerti
-- possiamo lavorare con l'operazione di join
-- cerco le aziende che compaiono in s1 ed s2 con il medesimo business ma servizio diverso
SELECT distinct s1.business
FROM services s1, services s2
WHERE s1.business = s2.business AND s1.feature <> s2.feature;

SELECT distinct s1.business
FROM services s1 INNER JOIN services s2 ON (s1.business = s2.business AND s1.feature <> s2.feature);

-- estrarre le aziende che offrono sia il servizio Alcohol e HappyHour
-- join riflessivo o self join
SELECT distinct s1.business
FROM services s1, services s2
WHERE s1.feature = 'Alcohol' AND s2.feature = 'HappyHour' AND s1.business = s2.business;

-- soluzione errata
SELECT business
 FROM services s 
 WHERE feature = 'Alcohol' AND feature = 'HappyHour';

-- operatore insiemistico
-- intersect
select s1.business
From services s1 
where s1.feature = 'Alcohol'
intersect
select s2.business
from services s2
where s2.feature = 'HappyHour'

-- subquery
select business
from services s 
where s.feature = 'Alcohol' and s.business IN (
select business
from services s 
where s.feature = 'HappyHour');

-- trovare le aziende che offrono il servizio Alcohol oppure il servizio HappyHour
SELECT distinct business
 FROM services s 
 WHERE feature = 'Alcohol' OR feature = 'HappyHour';

-- soluzione alternativa con operatori insiemistici
-- UNION: esclude i duplicati
-- UNION ALL: non esclude i duplicati
SELECT distinct business
 FROM services s 
 WHERE feature = 'Alcohol'
 UNION [ALL]
 SELECT distinct business
 FROM services s 
 WHERE feature = 'HappyHour';

-- restituire le aziende che sono di categoria Restaurants e Seafood
-- operatore insiemistico: intersect
select business
from incat i 
where category = 'Restaurants'
INTERSECT
select business
from incat i 
where category = 'Seafood'

-- restituire le aziende che sono di categoria Restaurants oppure Seafood
-- operatore insiemistico: union
select business
from incat i 
where category = 'Restaurants'
UNION
select business
from incat i 
where category = 'Seafood'

-- restituire le aziende che sono di categoria Restaurants E NON  Seafood
-- operatore insiemistico: except
select business
from incat i 
where category = 'Restaurants'
except
select business
from incat i 
where category = 'Seafood'


-- soluzione basata su join quando cerco aziende Restaurants e Seafood
select i_restaurants.business
from incat i_restaurants, incat i_seafood
WHERE i_restaurants.category = 'Restaurants' AND 
i_seafood.category = 'Seafood' AND i_restaurants.business = i_seafood.business;
 

-- restituire le aziende che non sono categorizzate
-- operatore insiemistico
select id
from business
except
select distinct business
from incat;

-- soluzione basata su join
SELECT b.id
FROM business b LEFT JOIN incat i ON b.id = i.business
WHERE i.business is null;


-- estrarre il nome dei revisori che non hanno mai fatto review con più di 4 stelle 
-- soluzione non corretta perchè non esclude i reviewer che hanno sia review sopra la soglia sia review sotto la soglia
SELECT reviewer.id, reviewer.name, review.stars
FROM reviewer INNER join review ON (reviewer.id = review.reviewer AND review.stars <= 4);

-- altra soluzione errata
SELECT reviewer.id, reviewer.name, review.stars
FROM reviewer INNER join review ON reviewer.id = review.reviewer WHERE review.stars <= 4;

-- filtro la tabella review prendendo i record complementari a quello che cerco (cioè review.stars > 4)
-- faccio join con reviewer e prendo solo i reviewer che non hanno corrispondenza con il filtro precedente

-- soluzione con join
SELECT reviewer.id, reviewer.name
FROM reviewer left join review on (reviewer.id = review.reviewer and review.stars > 4)
where review.reviewer is null;

-- soluzione con CTE (Common Table Expression)
WITH review_over_4 as (
select distinct reviewer
from review 
where review.stars > 4)
select reviewer.id, reviewer.name
FROM reviewer left join review_over_4 on reviewer.id = review_over_4.reviewer
where review_over_4.reviewer is null;


-- soluzione con except
select id, name 
from reviewer r 
except
select distinct r2.reviewer, name
from review r2 inner join reviewer 
	on reviewer.id = r2.reviewer
where stars > 4;

-- trovare le aziende nella medesima categoria degli Starbucks di Las Vegas

-- starbucks di Las Vegas
SELECT business.id 
from business inner join city on business.city = city.id 
where business.name = 'Starbucks' AND city.name ='Las Vegas' and country = 'NV'

-- categorie di starbucks in Las Vegas
with starbucks_las_vegas as (
SELECT business.id 
from business inner join city on business.city = city.id 
where business.name = 'Starbucks' AND city.name ='Las Vegas' and country = 'NV')
SELECT distinct incat.category
from incat inner join starbucks_las_vegas ON incat.business = starbucks_las_vegas.id;

-- query principale:
-- aziende che hanno almeno una delle categorie degli Starbucks di Las Vegas
with starbucks_las_vegas as (
SELECT business.id 
from business inner join city on business.city = city.id 
where business.name = 'Starbucks' AND city.name ='Las Vegas' and country = 'NV'),

starbucks_categories as (
SELECT distinct incat.category
from incat inner join starbucks_las_vegas ON incat.business = starbucks_las_vegas.id)

select distinct incat.business
from incat inner join starbucks_categories ON incat.category = starbucks_categories.category;

-- alternativa
select distinct incat.business
from incat 
where category in 
(select category from starbucks_categories);



-- aziende che hanno almeno una delle categorie degli Starbucks di Las Vegas e un valore di business.stars > media delle stars di tutti gli starbucks_las_vegas



-- aziende che hanno tutte le categorie degli Starbucks di Las Vegas 
-- suggerimento: un'azienda b è nel risultato se non esiste una categoria di starbucks_las_vegas per la quale non esiste un record di b in incat
