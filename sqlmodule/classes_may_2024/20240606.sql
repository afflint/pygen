-- operatori aggregati di SQL
-- sum()
-- avg()
-- min() / max()
-- count()

--* estrarre lo score più alto / più basso / medio ricevuto da un business in una review
SELECT max(stars) as max_stelle, min(stars) as min_stelle, avg(stars) as media_stelle
from review 

-- estrarre lo score più alto / basso /medio delle attività commerciali di Las Vegas
SELECT max(review.stars) as max_stelle, min(review.stars) as min_stelle, avg(review.stars) as media_stelle
from review inner join business on review.business = business.id inner join city on business.city = city.id
where city.name = 'Las Vegas';

-- estrarre lo score più alto / basso /medio delle attività commerciali di Las Vegas che si chiamano Starbucks
SELECT max(review.stars) as max_stelle, min(review.stars) as min_stelle, avg(review.stars) as media_stelle, sum(review.stars) * 1.0 / count(*) 
from review inner join business on review.business = business.id inner join city on business.city = city.id
where city.name = 'Las Vegas' and business.name = 'Starbucks';

-- trovare le aziende di Las Vegas la cui media di valutazioni è superiore alla media considerando tutte le aziende di Las Vegas
-- usiame le cte
with lv_business as (
select business.id, business.name, business.stars
from business inner join city on business.city = city.id
where city.name = 'Las Vegas'
), lv_avg as (
select avg(review.stars) as avg_value
from review inner join lv_business on review.business = lv_business.id
)
-- restituisco solo le aziende di lv_business il cui business.stars > lv_avg.avg_value
select *
from lv_business, lv_avg
where lv_business.stars > lv_avg.avg_value


--* estrarre il numero di business di Pizza Hut
select count(*)
from business 
where name = 'Pizza Hut';

-- numero complessivo review
select count(*)
from review

--* estrarre il numero di recensioni ricevute da tutti i Pizza Hut
select count(*)
from review inner join business on review.business = business.id
where name = 'Pizza Hut';

--* estrarre il valore medio di stelle di tutti i Pizza Hut
-- diamo un'occhiata alle operazioni di cast
select count(*), sum(review.stars), avg(review.stars), sum(review.stars) * 1.0 / count(*)
from review inner join business on review.business = business.id
where name = 'Pizza Hut';

select count(*), sum(review.stars), avg(review.stars), 
cast(sum(review.stars) as real) / count(*)
from review inner join business on review.business = business.id
where name = 'Pizza Hut';

-- estrarre il numero complessivo di categorie disponibili


-- estrarre il numero complessivo di opinioni cool rispetto alle recensioni di Susan 
select count(*), sum(review.cool), count(review.cool)
from review inner join reviewer on review.reviewer = reviewer.id
where name = 'Susan'

-- restituire il numero di recensori (reviewer) che non hanno valore per l'attributo cool o l'attributo funny
select count(*), count(cool), count(funny)
from reviewer

select * from reviewer where cool is null

select * from reviewer where funny is not null

-- restituire il numero di nome di aziende usato almeno una volta
select count(*), count(name), count(distinct name)
from business

select count(*), count(name), count(distinct name)
from business
where name like 'starbucks'

Starbucks
starbucks
starBucks
STARBUCKS

-- restituire il numero di occorrenze per ogni nome di azienda (non considerando le differenze di maiuscola/minuscola)
-- NON è possibile restituire attributi che non compaiono nella clausola GROUP BY: non è possibile restituire city
SELECT lower(name), city, count(*)
from business 
where name = 'starbucks' or name = 'Starbucks' or name = 'STARBUCKS'
group by lower(name)
order by 2 desc

-- restituire il numero di occorrenze per ogni nome di azienda (non considerando le differenze di maiuscola/minuscola) in ogni città
SELECT lower(name), city, count(*)
from business 
where upper(name) = 'STARBUCKS' 
group by lower(name), city
order by 3 desc


--* estrarre il numero di categorie usate da almeno un business


--* per ogni business, estrarre il numero di recensioni e il numero massimo di stelle ricevute in una review
SELECT business, count(*), count(distinct reviewer), max(stars), min(stars)
from review  
group by review.business

--* per ogni business, estrarre il numero di recensioni e il numero massimo di stelle ricevute in una review
-- quando almeno un recensore l'ha valutata due volta
SELECT business, count(*), count(distinct reviewer), max(stars), min(stars)
from review  
group by review.business
having count(*) <> count(distinct reviewer)

--* per ogni business, estrarre il numero di recensioni e il numero massimo di stelle ricevute in una review
-- quando la differenza fra max e min non è superiore a 1 e il numero di recensioni del business è superiore a 10 
SELECT business, count(*), count(distinct reviewer), max(stars), min(stars)
from review  
group by review.business
having ((max(stars) - min(stars)) <= 1) and count(*) > 10

-- restituire il numero di aziende che sono contenute nell'ultima query
with business_10_max_min as (
SELECT business, count(*), count(distinct reviewer), max(stars), min(stars)
from review  
group by review.business
having ((max(stars) - min(stars)) <= 1) and count(*) > 10
)
select count(*)
from business_10_max_min;


-- per ogni business di categoria "food", estrarre il numero di recensioni ricevute (considerando anche i business privi di recensioni)


--* per ogni business di categoria "food", estrarre il numero di recensioni con meno di 3 stelle 
-- filtro prima del raggruppamento (query A)
with food_business as (
select business
from incat 
where category = 'Food'
)
select review.business, count(*)
from review inner join food_business on review.business = food_business.business 
where stars < 3
group by review.business
order by 2 desc

-- filtro dopo il raggruppamento (query B)
with food_business as (
select business
from incat 
where category = 'Food'
)
select review.business, count(*)
from review inner join food_business on review.business = food_business.business 
group by review.business
having stars < 3
order by 2 desc

-- perchè abbiamo due risultati diversi?
-- la query B con having stars < 3 non funziona su sistemi relazionali diversi da sqlite: non è possibile operare selezioni su attributi che non sono oggetto di clausola di raggruppamento
-- la soluzione corretta prevede il filtro su stars < 3 prima del raggruppamento (query A)


-- per ogni business, mostrare il rapporto fra recensioni totali e recensioni sotto alla soglia 3 stelle
with business_count_review as (
select business, count(*) as tot_count
from review 
group by business), business_count_negative as (
select business, count(*) tot_negative_count
from review 
where stars < 3
group by business
)
SELECT bcr.business, bcn.business, tot_count, tot_negative_count, tot_negative_count * 1.0 / tot_count
from business_count_review bcr, business_count_negative bcn
where bcr.business = bcn.business
order by 5 desc


--* per ogni revisore, estrarre il numero di recensioni prodotte. Restituire anche il nome del revisore nel risultato. Si considerino nel risultato anche i revisori che non hanno eseguito alcuna recensione. Si conti una volta sola quando il revisore ha valutato il medesimo business più di una volta
-- count(distinct business) è l'operazione giusta per contare le recensioni come richiesto
select reviewer.id, name, count(*), count(business), count(distinct business)
from review right join reviewer on review.reviewer = reviewer.id
group BY reviewer.id, name 
-- having count(*) <> count(business)



-- restituire i revisori che hanno recensito la stessa attività più di una volta


--* per ogni categoria, estrarre il numero di business associati 


--* estrarre il business con più di 5 servizi offerti 



--* estrarre il nome dei revisori che hanno eseguito più di 10 review con almeno 3 stelle 
select reviewer, name, count(*)
from review inner join reviewer on review.reviewer = reviewer.id
where stars > 3  
group BY review.reviewer, name 
HAVING count(business) > 10
order by 2

-- la versione seguente produce un risultato diverso e sbagliato
-- nella group by ci deve sempre essere un attributo identificativo degli oggetti da raggruppare
select name, count(*)
from review inner join reviewer on review.reviewer = reviewer.id
where stars > 3  
group BY name 
HAVING count(business) > 10


--* estrarre i nomi dei revisori che sono univoci 

-- aziende che hanno almeno una delle categorie degli Starbucks di Las Vegas e un valore di business.stars > media delle stars di tutti gli starbucks_las_vegas

-- restituire il nome del revisore che ha eseguito il maggior numero di recensioni
-- potrebbe anche essere più di uno il risultato 
-- soluzione non completamente soddisfacente
select reviewer, name, count(*)
from review inner join reviewer on review.reviewer = reviewer.id 
group BY reviewer, name 
order by 3 desc

with reviewer_count as (
select reviewer, name, count(*) as tot_review
from review inner join reviewer on review.reviewer = reviewer.id 
group BY reviewer, name), reviewer_max as (
select max(tot_review) as max_review
from reviewer_count 
)
select * 
from reviewer_count, reviewer_max
where tot_review = max_review

-- estrarre il nome e la media delle stelle ricevute da business nella categoria food che offrono almeno 5 servizi


