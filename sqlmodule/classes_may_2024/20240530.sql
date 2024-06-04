-- è possibile importare dati da una fonte esterna (come un foglio excel in formato csv)
-- usare "importa dati" facendo tasto destro sul db in dbeaver
-- in questo modo è possibile aggiungere una tabella al db con il contenuto del folio excel
-- eseguire il seguente comando per accodare i dati importati a quelli di un'altra tabella
insert into city(id, name, country) 
select distinct cap3, provincia, 'Italy' from province where area = 'provincia';

-- estrarre le attività che riguardano la pizza (il termine pizza compare nel nome)
-- like lavora con segnaposto che permettono di specificare quello che volete cercare in forma approssimata
-- %: stringa/testo di qualsiasi lunghezza
-- _: stringa/testo di lunghezza 1 carattere
select *
from business b 
where name like '%pizza%'

-- trovare le attività il cui nome inizia per pizza
select *
from business b 
where name like 'pizza %'

-- trovare le attività il cui nome finisce per pizza
select *
from business b 
where name like '% pizza'

-- estrarre il nome delle attività che risultano attive e non hanno indicazione del vicinato (neighborhood)
select *
from business b 
where is_active = 1 and (neighborhood is null or neighborhood = ''); 


-- estrarre le aziende attive e senza indicazione dell'attributo street
select *
from business b 
where is_active = 1 and (street is null or street ='');

-- trovare i reviewer per i quali ci sono valori di funny
select *
from reviewer r 
where funny is not null;

-- cerco i revisori che hanno la stringa vuota come valore dell'attributo funny 
select *
from reviewer r 
where funny = ''

-- cerco i revisori che hanno lo spazio come valore dell'attributo funny 
select *
from reviewer r 
where funny = ' '

-- operazioni di join
-- restituire le aziende che appartengono alla categoria Food
-- la tabella incat rappresenta una relazione molti-a-molti fra business e categorie
SELECT b.id, b.name, i.*
from business b inner join incat i on b.id = i.business
WHERE category = 'Food';

SELECT b.id, b.name, i.*
from business b, incat i
where b.id = i.business AND category = 'Food' ;

-- restituire il nome delle aziende che vendono Alcohol
-- business: 174.567
-- services: 138.152
-- il prodotto cartesiano fra business e services: 174.567 x 138.152
SELECT business.id, business.name, services.*
from business, services
where business.id = services.business and feature like 'alcohol'

SELECT business.id, business.name, services.*
from business inner join services on business.id = services.business
where feature = 'Alcohol'

-- il join fra due tabelle è possibile quando in una delle due tabelle abbiamo una CHIAVE ESTERNA che punta (fa riferimento) alla chiave primaria dell'altra tabella

-- per ogni azienda mostrare il nome dei revisori che l'hanno valutata con il relativo giudizio
SELECT business.id, business.name, review.*, reviewer.id, reviewer.name
from business, review, reviewer
where business.id = review.business and reviewer.id = review.reviewer

SELECT business.id, business.name, review.*, reviewer.id, reviewer.name
from business inner join review on business.id = review.business inner join reviewer on reviewer.id = review.reviewer;   

-- per ogni azienda mostrare il nome dei revisori che l'hanno valutata e il relativo giudizio quando superiore a 4
SELECT business.id, business.name, review.*, reviewer.id, reviewer.name
from business inner join review on business.id = review.business inner join reviewer on reviewer.id = review.reviewer
where review.stars > 4;

-- trovare il nome delle aziende che sono aperte di domenica
select business.id, business.name, schedule.*
from business, schedule 
where business.id = schedule.business and day = 'sunday'

-- trovare il nome delle aziende che sono aperte di domenica nella città di Las Vegas
select business.id, business.name, city.id, city.name
from business, schedule, city 
where (business.id = schedule.business) and ("day" = 'sunday') and (city.name = 'Las Vegas') and (business.city = city.id)

-- where ((business.id = schedule.business) and (business.city = city.id)) and ("day" = 'sunday') and (city.name = 'Las Vegas')


-- trovare le aziende che non offrono servizi (se esistono)
-- oltre a inner join (che restituisce i record che trovano corrispondenza rispetto alla condizione di join) sono stati messi a disposizione operatori di join esterno
-- left/right join 
-- full join
-- left join aggiunge al risultato di inner i record spuri della tabella a sinistra del join
select business.id, business.name, services.*
from business left join services on business.id = services.business 
where services.business is null

-- right join è analogo a left ma inverte il ruolo delle tabelle  
select business.id, business.name, services.*
from business right join services on business.id = services.business 
where business.id is null

select business.id, business.name, services.*
from services right join business on business.id = services.business 
where services.business is null

-- full join è equivalente a inner + left + right
select business.id, business.name, services.*
from services full join business on business.id = services.business 

-- altra soluzione per trovare le aziende che non offrono servizi (se esistono)
-- subquery o query nidificata/innestata
select id, name
from business 
where id not in (
select business from services)

-- soluzione con except
select id
from business 
except
select business 
from services

-- il nome delle attività che offrono sia servizi di WheelchairAccessible sia di BusinessParking_valet
select id, name
from business b inner join services s on b.id = s.business
where s.feature = 'WheelchairAccessible' and b.id in (
select business from services where feature = 'BusinessParking_valet');

-- soluzione alternativa
select id, name
from business b inner join services s on b.id = s.business
where s.feature = 'WheelchairAccessible'
intersect 
select id, name
from business b inner join services s on b.id = s.business
where s.feature = 'BusinessParking_valet'

-- la seguente query è uguale alla precedente? no ed è errata perchè il nome delle aziende può non essere univoco e quindi aziende omonime ma diverse possono portare a risultati non corretti
select name
from business b inner join services s on b.id = s.business
where s.feature = 'WheelchairAccessible'
intersect 
select name
from business b inner join services s on b.id = s.business
where s.feature = 'BusinessParking_valet'

-- soluzione alternativa con i join
select *
from services s1, services s2
where s1.feature = 'WheelchairAccessible' and s2.feature = 'BusinessParking_valet' and s1.business = s2.business

-- estrarre i nomi dei revisori che sono amici 
SELECT ra.id, ra.name, rb.id, rb.name, friend.*
from friend inner join reviewer ra on friend.reviewer_a = ra.id inner join reviewer rb on friend.reviewer_b = rb.id

-- trovare le aziende che hanno almeno una categoria uguale a quelle degli Starbucks di Las Vegas

-- trovo prima gli Starbucks di Las Vegas
SELECT *
from business inner join city on business.city = city.id
where business.name ='Starbucks' and city.name = 'Las Vegas'

-- trovo le categorie delle aziende Starbucks di Las Vegas
-- Common Table Expressions (CTE)
with starbucks_lv as (
SELECT business.id, business.name
from business inner join city on business.city = city.id
where business.name ='Starbucks' and city.name = 'Las Vegas'
)
SELECT distinct category
from starbucks_lv inner join incat on starbucks_lv.id = incat.business 

-- trovare le aziende che hanno almeno una categoria in comune alle precedenti
with starbucks_lv as (
SELECT business.id, business.name
from business inner join city on business.city = city.id
where business.name ='Starbucks' and city.name = 'Las Vegas'
),
categories_slv as (SELECT distinct category
from starbucks_lv inner join incat on starbucks_lv.id = incat.business)
SELECT distinct incat.business
from categories_slv inner join incat on categories_slv.category = incat.category

-- trovare le attività che non sono recensite da revisori con meno di 4 stelle di media (tutti i revisori reviewer.average_stars >= 4)
-- le attività recensite SOLO da revisori con 4+ stelle non hanno recensioni da revisori con meno di 4 stelle
-- prendiamo solo i business che non compaiono nell'insieme dei business che sono stati valutati almeno una volta da un revisore con meno di 4 stelle

-- soluzione sbagliata
select business
from review inner join reviewer on review.reviewer = reviewer.id 
where reviewer.average_stars >= 4

-- soluzione corretta
with reviewers_4s as (
select id 
from reviewer r 
where average_stars < 4
),
review_4s as (
SELECT review.business
from review inner join reviewers_4s on review.reviewer = reviewers_4s.id
)
select id
from business
where id not in (select business from review_4s);

-- alternativa all'ultima query 
with reviewers_4s as (
select id 
from reviewer r 
where average_stars < 4
),
review_4s as (
SELECT review.business
from review inner join reviewers_4s on review.reviewer = reviewers_4s.id
)
select id 
from business left join review_4s on business.id = review_4s.business
where review_4s.business is null;