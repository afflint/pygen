-- comandi di interrogazione o query di tabelle

-- trovare i business con più di 100 recensioni
SELECT id, name, review_count 
FROM business 
WHERE review_count > 100;
 
-- trovare i business con più di 100 e meno di 200 recensioni
SELECT id as id_azienda, name as "nome azienda", review_count  as "recensioni ricevute"
FROM business 
WHERE review_count > 100 and review_count < 200;

-- salvare una query come vista (view)
create view business_100_200 as 
SELECT id, name, review_count 
FROM business 
WHERE review_count > 100 and review_count < 200;

-- trovare le aziende il cui nome è McDonald's
select *
from business b
where b.name = 'McDonald''s';

-- trovare le aziende il cui nome è Starbucks
select *
from business 
where business.name = 'Starbucks';

-- trovare le aziende con almeno 4 stelle di valutazione
select id, name, stars
from business 
where stars >= 4
order by name DESC, stars;

-- sintassi alternativa (con ordine in base alla posizione)
select id, name, stars
from business 
where stars >= 4
order by 2 DESC, 3;

-- trovare le aziende che hanno rapporto fra il valore dell'attributo stars e il valore dell'attributo review_count inferiore a 3
select id, name, stars, review_count, stars/review_count
from business b 
where stars/review_count < 3
order by 5;

-- trovare i revisori (reviewer) che hanno una media di valutazioni (average_stars) superiore a 4 OPPURE hanno più di 50 recensioni
SELECT *
from reviewer r 
where (r.average_stars > 4) OR (review_count > 50);

-- trovare le aziende che non sono collocate nella città D66C6A
select *
from business
where city <> 'D66C6A';

-- sintassi alternativa
select *
from business
where NOT(city = 'D66C6A');

-- trovare le aziende che sono collocate nella città 561403 oppure 75E7C8 oppure 7A9485
select *
from business b 
where (city = '561403') or ((city = '75E7C8') or (city = '7A9485'))

-- sintassi alternativa: operatore IN
select *
from business b 
where b.city in ('561403', '75E7C8', '7A9485');

-- trovare i nomi delle aziende che sono a Las Vegas o Toronto
-- prova di join (incompleto: non ancora funzionante)
select business.name, city.name
from business, city
where city.name = 'Toronto' or city.name = 'Las Vegas';

-- alternativa
select b.name, c.name
from business b, city c 
where c.name = 'Toronto' or c.name = 'Las Vegas';

-- join: operazione che combina il contenuto di due o più tabelle
select business.id, business.name, business.city, city.id, city.name 
from business, city
where (business.city = city.id) and (city.name = 'Toronto' 
        OR city.name = 'Las Vegas');

-- sintassi alternativa per i join 
select business.id, business.name, business.city, city.id, city.name 
from business inner join city on business.city = city.id
where city.name = 'Toronto' OR city.name = 'Las Vegas';

-- sintassi alternativa 
select business.id, business.name, business.city, city.id, city.name 
from business inner join city on business.city = city.id
where city.name in ('Toronto','Las Vegas');

-- trovare le categorie di appartenenza di ciascuna azienda
SELECT b.id, b.name, i.*
from business b, incat i
where b.id = i.business;

SELECT b.id, b.name, i.*
from business b inner join incat i on b.id = i.business;

-- restituire le aziende che appartengono alla categoria Food
SELECT b.id, b.name, i.*
from business b inner join incat i on b.id = i.business
WHERE category = 'Food';

SELECT b.id, b.name, i.*
from business b, incat i
where b.id = i.business AND category = 'Food' ;






