-- restituire il nome delle attività commerciali nella città di Las Vegas
select business.id, business.name, city.*
from business, city
where business.city = city.id and city.name = 'Las Vegas' and country = 'NV'

-- sintassi alternativa 
select business.id, business.name, city.*
from business inner join city on business.city = city.id
where city.name = 'Las Vegas' and country = 'NV'

-- restituire il nome delle attività commerciali che offrono il servizio WiFi
SELECT business.id, business.name 
from business inner join services on business.id = services.business
where services.feature = 'WiFi'

-- join completo (ma ridondante)
SELECT business.id, business.name 
from business inner join services on business.id = services.business INNER JOIN feature ON services.feature = feature.name
where feature.name = 'WiFi'

-- restituire il nome delle attività che offrono sia il servizio WheelchairAccessible sia il servizio BusinessParking_valet
SELECT business.id, business.name 
from business inner join services on business.id = services.business
-- where services.feature in ('WheelchairAccessible', 'BusinessParking_valet')
where services.feature = 'WheelchairAccessible' and services.feature = 'BusinessParking_valet'

-- noi cerchiamo NON un record che soddisfa due condizioni (WheelchairAccessible e BusinessParking_valet)
-- noi cerchiamo due record in cui in un caso feature = 'WheelchairAccessible' e nell'altro feature = 'BusinessParking_valet' e l'azienda è la stessa 
-- soluzione con subquery
select business.id, business.name 
from business inner join services on business.id = services.business
where feature = 'WheelchairAccessible' and business.id in (
select business.id
from business inner join services on business.id = services.business
where feature = 'BusinessParking_valet')

-- soluzione con operatore insiemistico
-- operazioni insiemistiche: unione, intersezione, sottrazione
-- intersect restituire i record che appartengono al risultato di entrambe le query combinate dall'operatore intersect
-- condizioni: le due query devono avere lo stesso numero di attributi restituiti e gli attributi devono corrispondersi posizionalmente
-- importante restituire la chiave degli oggetti in entrambe le query
select business.id, business.name 
from business inner join services on business.id = services.business
where feature = 'WheelchairAccessible'
intersect
select business.id, business.name
from business inner join services on business.id = services.business
where feature = 'BusinessParking_valet'

-- soluzione con self-join
-- noi cerchiamo due record in cui in un caso feature = 'WheelchairAccessible' e nell'altro feature = 'BusinessParking_valet' e l'azienda è la stessa 
select *, business.name
from services s_wheelchair inner join services s_parking on s_wheelchair.business = s_parking.business inner join business on business.id = s_wheelchair.business
where s_wheelchair.feature = 'WheelchairAccessible' and s_parking.feature = 'BusinessParking_valet'

-- sintassi alternativa
select *
from services s_wheelchair, services s_parking, business 
where s_wheelchair.feature = 'WheelchairAccessible' and s_parking.feature = 'BusinessParking_valet' and s_wheelchair.business = s_parking.business and business.id = s_wheelchair.business

-- restituire le aziende che non offrono servizi
-- soluzione con operatore insiemistico: sottrazione
-- cerchiamo le aziende che figurano nella tabella business e non figurano nella tabella services
-- distinct elimina i duplicati dal risultato di una query
-- l'opportunità di usare distinct dipende dalla numerosità degli oggetti e dal numero di confronti che la query deve eseguire
-- nei dbms sono offerti operatori per stimare il costo di esecuzione di una query (e.g., postgres: explain)
SELECT id, name 
from business
except
SELECT distinct business, name
from services inner join business on services.business = business.id

-- soluzione con subquery
SELECT id, name 
from business
where id not in (
SELECT distinct business
from services)

 -- soluzione con join 
-- ci serve un join esterno: left join
-- left join: al risultato di inner join aggiunge/accoda i record della tabella di sinistra (in questo caso business) che non hanno legami con la tabella di destra (in questo caso services): sono i cosiddetti record spuri della tabella di sinistra
select b.id, b.name, s.*
from business b left outer join services s on b.id = s.business
where s.business is null

-- versione con right join 
select b.id, b.name, s.*
from services s right outer join business b on b.id = s.business
where s.business is null


-- restituire le aziende che non offrono il servizio di WiFi
-- con union aggiungo le aziende che non hanno servizi
-- questa soluzione non tiene conto che aziende associate a più servizi finiscono comunque nel risultato anche se uno dei servizi è proprio WiFi
SELECT business.id, business.name 
from business inner join services on business.id = services.business
where services.feature <> 'WiFi'
union 
select b.id, b.name
from services s right outer join business b on b.id = s.business
where s.business is null

-- soluzione: except
SELECT id, name 
from business
except
SELECT distinct business, name
from services inner join business on services.business = business.id
where services.feature = 'WiFi'

-- soluzione con subquery
SELECT id, name 
from business
where id not in (
SELECT distinct business
from services inner join business on services.business = business.id
where services.feature = 'WiFi')

-- soluzione con left join
select b.id, b.name, s.*
from business b left outer join services s on b.id = s.business and s.feature = 'WiFi'
where s.business is null 

--soluzione con vista (che scompone il problema)
create view business_wifi as 
SELECT distinct business
from services 
where services.feature = 'WiFi' 

-- query con il risultato usando la vista come passo intermedio
select b.id, b.name, bw.*
from business b left outer join business_wifi bw on b.id = bw.business 
where bw.business is null 

-- soluzione alternativa (come vista) usando cte
-- common table expression
with business_wifi as (
SELECT distinct business
from services 
where services.feature = 'WiFi')
select b.id, b.name, bw.*
from business b left outer join business_wifi bw on b.id = bw.business 
where bw.business is null 


-- trovare le aziende che appartengono alle categorie Food e Pizza
with business_pizza as (
select business
from incat i
where category = 'Pizza'), 
business_food as (
select business
from incat i
where category = 'Food')
select *
from business_pizza bp inner join business_food bf ON bp.business = bf.business inner join business b on b.id = bp.business

-- trovare i recensori delle aziende Starbucks che hanno fatto almeno 10 recensioni
with reviewer_almeno_10 as (
select id, name
from reviewer r
where review_count >= 10),
business_starbucks as (
select id 
from business b
where name = 'Starbucks')
select *
from review inner join reviewer_almeno_10 r10 on review.reviewer = r10.id inner join business_starbucks bs on review.business = bs.id

-- trovare i nomi dei recensori che hanno valutato solo aziende Starbucks
-- recensori che hanno valutato Starbucks e non hanno valutato aziende diverse da Starbucks
with business_starbucks as (
select id 
from business b
where name = 'Starbucks'),
business_non_starbucks as (
select id 
from business b
where name <> 'Starbucks'),
review_starbucks as (
select review.*
from review inner join business_starbucks bs on review.business = bs.id),
review_non_starbucks as (
select review.*
from review inner join business_non_starbucks bs on review.business = bs.id),
reviewer_starbucks as (
select r.id, r.name 
from reviewer r inner join review_starbucks rs on r.id = rs.reviewer),
reviewer_non_starbucks as (
select r.id, r.name 
from reviewer r inner join review_non_starbucks rs on r.id = rs.reviewer)
select *
from reviewer_starbucks 
except
select *
from reviewer_non_starbucks

-- trovare le aziende che non hanno categorie in comune con starbucks
-- trovare le categorie degli starbucks
-- restituire quelle aziende le cui categorie non hanno elementi in comune con quelle di starbucks
with starbucks_cat as (
select distinct category
from incat inner join business on incat.business = business.id
where name = 'Starbucks')
SELECT id  
FROM business b
where not exists (
select *
from starbucks_cat sc 
where not exists (
select * 
from incat i
where i.business = b.id and i.category = sc.category)) 

starbucks_cat: C1, C2, C3

incat
business | category
A1 			C1
A1			C4
A1			C5
A2			C4
A2			C5
A3 			C1
A3			C2



