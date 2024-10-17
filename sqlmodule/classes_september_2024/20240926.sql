-- operatori aggregati: sum, max, min, avg, count
-- aggregazioni: group by, having 

-- restituisci il valore in termini di stelle (star) massimo/minimo/medio della recensione degli Starbucks
-- utilizzeremo gli operatori max/min/avg
-- gli operatori aggregati compaiono nella clausola select 
-- tutti prevedono come argomento il nome di uno e un solo attributo
SELECT max(review.stars) as "valore massimo recensione", min(review.stars) as "valore minimo recensione", avg(review.stars) as "valore medio recensione"
from review inner join business on review.business = business.id 
where name = 'Starbucks';

-- focalizziamo sullo Starbucks con codice lHYiCS-y8AFjUitv6MGpxg
select max(stars), min(stars), avg(stars)
from review 
where business = 'lHYiCS-y8AFjUitv6MGpxg';

-- quante recensioni hanno ricevuto gli Starbucks
-- utilizzeremo l'operatore count
-- count(*) conta i record nel risultato della query
select count(*) as "numero recensioni"
from review inner join business on review.business = business.id 
where name = 'Starbucks'; 

-- focalizziamo sullo Starbucks con codice lHYiCS-y8AFjUitv6MGpxg
select count(*)
from review 
where business = 'lHYiCS-y8AFjUitv6MGpxg';

-- verificare se business.review_count coincide con il risultato di count(*) su review. restituire le aziende per le quali i due conteggi differiscono

-- contare il numero di review di Starbucks con cool positivo 
-- count su uno specifico attributo conta i valori su quell'attributo
-- e i valori nulli non vengono considerati (non contribuiscono alla count)
select count(*) as "numero recensioni", count(cool)
from review inner join business on review.business = business.id 
where name = 'Starbucks' and cool > 0; 

-- modifico il contenuto di review e metto a null tutti i valori cool a zero
update review set cool = null where cool = 0;

-- ri-eseguiamo la query 
-- count non può includere più di un attributo
select count(*) as "numero recensioni", count(cool)
from review inner join business on review.business = business.id 
where name = 'Starbucks'; 

-- per ogni azienda Starbucks, restituire il numero di recensioni ottenuto
select business.id, count(*) as "numero recensioni", count(cool)
from review inner join business on review.business = business.id 
where name = 'Starbucks'
group by business.id
order by 2 DESC; 

-- per ogni revisore restituire il numero di recensioni prodotte
select reviewer, count(*)
from review 
group by reviewer 

-- aggiungo al risultato il nome del recensore
-- in presenza di group by non è possibile restituire attributi su cui non è stato eseguito il raggruppamento (in linea di principio i recordo di un gruppo possono avere valore diverso su attributi sui quali non è stato fatto il raggruppamento) 
select review.reviewer, name, count(*)
from review inner join reviewer on review.reviewer = reviewer.id 
group by review.reviewer, name

-- restituire il numero di recensioni di Starbucks per ogni recensore 
select review.reviewer, reviewer.name, count(*), count(business.id)
from review inner join reviewer on review.reviewer = reviewer.id inner join business on review.business = business.id 
where business.name = 'Starbucks'
group by review.reviewer, reviewer.name
order by 3 desc

-- restituire il numero di recensioni di Starbucks per ogni recensore che ne ha prodotte almeno 20
select review.reviewer, reviewer.name, count(*), count(business.id)
from review inner join reviewer on review.reviewer = reviewer.id inner join business on review.business = business.id 
where business.name = 'Starbucks'
group by review.reviewer, reviewer.name
having count(*) >= 20
order by 3 desc

-- quanti sono i recensori di Starbucks con recensioni fra 20 e 30?
with reviewer_over_20 as (
select review.reviewer, reviewer.name, count(*), count(business.id)
from review inner join reviewer on review.reviewer = reviewer.id inner join business on review.business = business.id 
where business.name = 'Starbucks'
group by review.reviewer, reviewer.name
having count(*) >= 20 and count(*) <= 30)
select count(*)
from reviewer_over_20;

-- restituire per ogni recensore il numero di recensioni per ogni azienda
select review.reviewer, review.business, name, count(*)
from review inner join reviewer on review.reviewer = reviewer.id 
group by review.reviewer, review.business, name

-- restituire per ogni recensore il numero di recensioni per ogni azienda quando maggiore di 1
-- restituire i recensori che hanno recensito la medesima azienda almeno due volte
select review.reviewer, review.business, name, count(*)
from review inner join reviewer on review.reviewer = reviewer.id 
group by review.reviewer, review.business, name
having count(*) > 1;

-- mostrare i dati delle recensioni dove il recensore ha recensito la medesima azienda almeno due volte
with reviewer_business_over_2 as (
select review.reviewer, review.business, name, count(*)
from review inner join reviewer on review.reviewer = reviewer.id 
group by review.reviewer, review.business, name
having count(*) > 1)
select r.*
from review r inner join reviewer_business_over_2 rb on r.reviewer = rb.reviewer and r.business = rb.business;

-- per ogni business restituire il numero di servizi erogati
SELECT business, count(*), count(feature)
from services
group by business 

-- per ogni business restituire il numero di servizi erogati e includere nel risultato anche i business che non erogano servizi
SELECT business.id, count(*), count(feature), count(services.business)
from services right join business on business.id = services.business 
group by business.id

-- per ogni città del Nevada (NV) restituire il numero di aziende che vi risiedono
SELECT city.id, city.name, count(business.id), count(*)
from city inner join business on business.city = city.id
where city.country = 'NV'
group by city.id, city.name

-- cosa possiamo dire delle città del Nevada nelle quali non ci sono attività?
-- per includere anche le città che non hanno attività dobbiamo usare left outer join
SELECT city.id, city.name, count(business.city), count(*)
from city left join business on business.city = city.id
where city.country = 'NV'
group by city.id, city.name
-- having count(business.city) = 0

-- elimino l'unica azienda della città 0448DD
delete from business where business.city = '0448DD';

-- per ogni città del Nevada (NV) restituire il numero di aziende Starbucks che vi risiedono
-- inserire nel risultato anche le città che non hanno Starbucks (ovviamente con count = 0)
SELECT city.id, city.name, count(business.city), count(*)
from city left join business on business.city = city.id and business.name = 'Starbucks'
where city.country = 'NV' 
group by city.id, city.name
order by 3 desc

-- alternativa
with city_nv as (
select id, name 
from city 
where country = 'NV'),
business_starbucks as (
select id, city 
from business 
where name = 'Starbucks')
SELECT cnv.id, cnv.name, count(bs.city)
from city_nv cnv left join business_starbucks bs on cnv.id = bs.city
group by cnv.id, cnv.name
order by 3 desc

-- considerare le categorie pizza e food
-- restituire il numero di categorie di ogni azienda che è in food o pizza 
with business_p_f as (
SELECT business, category
from incat
where category = 'Food' or category = 'Pizza') 
select incat.business, count(incat.category), count(business_p_f.category)
from business_p_f inner join incat on business_p_f.business = incat.business
group by incat.business;

-- per ogni azienda mostrare il numero di recensori 
-- in questo risultato vediamo il numero di recensioni ricevute perchè è possibile che un recensore valuti la stessa azienda più di una volta
SELECT business, name, count(reviewer) as "numero di recensioni", count(distinct reviewer) as "numero di recensori"
from review inner join business on business.id = review.business
group by business, name 
having count(reviewer) <> count(distinct reviewer)

-- la seguente è equivalente alla precedente query?
-- no: il business.name non è chiave e quindi possono esistere aziende diverse con il medesimo nome
SELECT name, count(reviewer) as "numero di recensioni", count(distinct reviewer) as "numero di recensori"
from review inner join business on business.id = review.business
group by name 
having count(reviewer) <> count(distinct reviewer)

-- trovare il recensore con il maggior numero di recensioni fatte
-- in sql non è possibile applicare un aggregato a un altro aggregato
SELECT max(count(business))
from review 
group by reviewer;

-- altra opzione 
SELECT reviewer, count(business)
from review 
group by reviewer
order by 2 desc
limit 1;

-- soluzione corretta
with reviewer_count as (
SELECT reviewer, count(business) as r_count
from review 
group by reviewer),
max_count as (
select MAX(r_count) as m_value
from reviewer_count)
select *
from reviewer_count rc inner join max_count mc on rc.r_count = mc.m_value;

-- soluzione alternativa
with reviewer_count as (
SELECT reviewer, count(business) as r_count
from review 
group by reviewer)
select *
from reviewer_count rc 
where r_count = (
select max(r_count)
from reviewer_count);

-- altra soluzione
SELECT reviewer, count(business) as r_count
from review 
group by reviewer
having count(business) >= all (
SELECT count(business) as r_count
from review 
group by reviewer);



