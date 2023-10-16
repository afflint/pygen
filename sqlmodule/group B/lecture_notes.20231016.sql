-- SQL Structured Query Language: linguaggio strutturato di interrogazione
-- query, interrogazione: operazione di estrazione dati

-- SQL è un linguaggio dichiarativo


-- prelevare id e nome delle aziende con almeno 4 stelle 
SELECT id, name
FROM business
WHERE stars > 4;
-- interroga la tabella business e mostra nel risultato i valori degli attributi id, name per i record che soddisfano la seguente condizione: il valore dell'attributo stars è maggiore di 4

-- voglio vedere l'intero contenuto della tabella business
SELECT *
FROM business;

-- il risultato di una query è una tabella "virtuale" che può essere esportata e salvata localmente
-- la query non ha alcun impatto sul contenuto della base di dati

-- una query può essere salvata come vista/view all'interno della base di dati
create view business4stelle as (
SELECT id, name
FROM business
WHERE stars > 4);

-- estrarre id, nome delle aziende con almeno 4 stelle e 50 review
-- operatori booleani: AND, NOT, OR
-- operatori confronto: = <> > >= < <=
SELECT id, name, stars, review_count
FROM business 
WHERE stars >= 4 AND review_count >= 50;

-- estrarre id, nome delle aziende con stelle comprese fra 3 e 4 e review comprese fra 10 e 50
SELECT id, name, stars, review_count
FROM business 
WHERE stars >= 3 AND stars <= 4 AND review_count >= 10 AND review_count <= 50;

-- estrarre id, nome delle aziende con stelle comprese fra 3 e 4 oppure review comprese fra 10 e 50
-- un record del risultato soddisfa almeno una delle seguenti:
-- ha valore di stars compreso fra 3 e 4
-- ha valore di review_count compreso fra 10 e 50
SELECT id, name, stars, review_count
FROM business 
WHERE stars >= 3 AND stars <= 4 OR review_count >= 10 AND review_count <= 50;
-- le condizioni nella clausola WHERE vengono verificate da sinistra a destra

SELECT id, name, stars, review_count
FROM business 
WHERE (stars >= 3 AND stars <= 4) OR (review_count >= 10 AND review_count <= 50);

-- usando operatore between
SELECT id, name, stars, review_count
FROM business 
WHERE stars between 3 AND 4 OR review_count between 10 AND 50;

-- estrarre le aziende che trattano di pizza
-- ricerca approssimata: like
-- like è un operatore "case insensitive" in sqllite
-- wildcard/segnaposto:
-- %: stringa di qualsiasi lunghezza
-- _: strainga di esattamente 1 carattere
select id, name
from business 
where name like '%pizza%';

-- estrarre le aziende il cui nome inizia per "pizza"
select id, name
from business 
where name like 'pizza%';
-- in DBMS dove like è case sensitive si può usare la funzione LOWER

-- estrarre le aziende il cui nome finisce per "pizza"
select id, name
from business 
where name like '%pizza';

-- come posso estrarre le aziende il cui nome contiene la parola pizza non all'interno di altre parole
-- voglio escludere le aziende che hanno pizzaiolo/pizzaville nel nome
select id, name
from business 
where name like '% pizza %' OR name like 'pizza %' 
			OR name like '% pizza';
			
-- estrarre le aziende collocate a Las Vegas (NV) oppure a Phoenix (AZ)
-- cerco nella tabella city il codice di Las Vegas e Phoenix
SELECT id
FROM city
WHERE (country = 'AZ' AND name = 'Phoenix') 
    OR (name = 'Las Vegas' AND country = 'NV'); 

-- poi vado nella tabella business ed estraggo i record con i codici corrispondenti
  SELECT id, name, city
  FROM business 
  WHERE city = '185B21' OR city = '4598F8';
 
 -- analoga soluzione con operatore IN
 SELECT id, name, city
 FROM business b 
 WHERE city IN ('185B21', '4598F8');

-- vediamo una soluzione con l'operazione di JOIN
-- le operazioni di join permettono di mettere in relazione tabelle diverse dove esistono legami di "chiave esterna" e "chiave primaria" definiti a livello di schema delle tabelle 

-- cosa è una chiave esterna: è un attributo (o una combinazione di attributi) che referenzia un attributo chiave di un'altra relazione
-- cosa è una chiave primaria: è un attributo (o una combinazione di attributi) non nullo il cui valore è univoco nella tabella
-- ogni tabella ha una e una sola chiave primaria
	
-- trovare per ogni business il nome della corrispondente città
SELECT b.id, b.name, b.city, c.id, c.name, country
FROM business b, city c
WHERE b.city = c.id

-- trovare i business delle città di Las Vegas (NV) o Phoenix (AZ)
SELECT b.id, b.name, b.city, c.id, c.name, country
FROM business b, city c
WHERE b.city = c.id AND ((country = 'AZ' AND c.name = 'Phoenix') 
    OR (c.name = 'Las Vegas' AND country = 'NV'));
  
-- sintassi alternativa con INNER JOIN
SELECT b.id, b.name, b.city, c.id, c.name, country
FROM business b INNER JOIN city c ON b.city = c.id
WHERE ((country = 'AZ' AND c.name = 'Phoenix') 
    OR (c.name = 'Las Vegas' AND country = 'NV'));
    
-- estarre le aziende di Las Vegas (NV) attive nella categoria "Steakhouses"
SELECT b.id as "id azienza", b.name as "nome azienda", c.name as città, incat.business as "id azienda", incat.category as categoria
FROM business b INNER JOIN city c ON b.city = c.id 
	INNER JOIN incat ON b.id = incat.business
WHERE (c.name = 'Las Vegas' AND country = 'NV') AND lower(category) = 'steakhouses'
ORDER BY 2 ASC
-- usare DESC per ordinare in modo decrescente (ASC è il default)
-- ORDER BY b.id
-- ORDER BY "id azienda";

-- aziende di cui non conosciamo la città che sono in categoria Steakhouses
select b.id, b.name
from business b INNER JOIN incat ON b.id = incat.business
WHERE city is null AND lower(category) = 'steakhouses';


