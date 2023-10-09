-- query con misure aggregate, cioè che utilizzano operatori aggregati
-- MAX
-- MIN
-- AVG
-- SUM
-- COUNT

-- quale è la review con il numero massimo/minimo di utenti che la giudicano utile
SELECT *, MAX(useful) as max_useful
FROM review;

WITH max_useful as (
SELECT MAX(useful) as max_value
FROM review)
SELECT review.* FROM review, max_useful 
WHERE useful = max_value;

-- trovare il numero totale di utenti che ha trovato utile una review
SELECT SUM(useful) as tot_useful
FROM review;

-- reperire il numero di utenti che ha trovato utile le review di ciascun revisore
SELECT reviewer, SUM(useful) as tot_useful, MAX(useful), MIN(useful)
FROM review
GROUP BY reviewer;

-- dettaglio delle review di uno specifico utente
SELECT *
FROM review r 
WHERE reviewer = '---1lKK3aKOuomHnwAkAow'

-- restituire il nome dei revisori con il corrispondente valore complessivo di useful
SELECT reviewer, name, SUM(review.useful) as tot_useful
FROM review INNER JOIN reviewer ON review.reviewer = reviewer.id
GROUP BY review.reviewer
ORDER BY 3 DESC;

-- la seguente query è equivalente?
-- SQL standard: gli attributi proiettati in una query con raggruppamento devono essere un sottoinsieme degli attributi su cui insiste il raggruppamento
SELECT reviewer.id, name, SUM(review.useful) as tot_useful
FROM review INNER JOIN reviewer ON review.reviewer = reviewer.id
GROUP BY reviewer.id, name
ORDER BY 3 DESC;

-- la seguente query è equivalente?
-- questa query non raggruppa per revisore, ma per revisori che hanno il medesimo nome: name non è identificativo del revisore
-- accertarsi di usare identificativi degli oggetti che si vogliono raggruppare
SELECT name, SUM(review.useful) as tot_useful
FROM review INNER JOIN reviewer ON review.reviewer = reviewer.id
GROUP BY name
ORDER BY 2 DESC;

-- considerazioni sulle materializzazioni degli operatori aggregati 
-- quanti utenti hanno trovato utili le review dell'utente Hugo (jYnkJR3T8yCERXywoVhWYA)
SELECT reviewer.id, name, SUM(review.useful) as tot_useful, SUM(review.cool) as tot_cool, SUM(review.funny) as tot_funny, AVG(review.stars) as avg_stars
FROM review INNER JOIN reviewer ON review.reviewer = reviewer.id
-- WHERE name = 'Hugo'
WHERE id = 'jYnkJR3T8yCERXywoVhWYA'
GROUP BY reviewer.id, name
ORDER BY 3 DESC;

-- soluzione con clausola HAVING
-- HAVING permette di fare selezioni sui gruppi
SELECT reviewer.id, name, SUM(review.useful) as tot_useful, SUM(review.cool) as tot_cool, SUM(review.funny) as tot_funny, AVG(review.stars) as avg_stars
FROM review INNER JOIN reviewer ON review.reviewer = reviewer.id
GROUP BY reviewer.id, name
HAVING id = 'jYnkJR3T8yCERXywoVhWYA'
ORDER BY 3 DESC;

-- in questo esempio eseguire il filtro con WHERE prima del raggruppamento è decisamente più efficiente


-- quale è la media delle valutazioni considerando tutte le review
SELECT AVG(stars)
FROM review


-- per ogni revisore, quale è la media delle valutazioni
SELECT reviewer, AVG(stars)
FROM review
GROUP BY reviewer


-- per ogni revisore, quale è il numero di review eseguite
SELECT reviewer, COUNT(*) as num_review
FROM review
GROUP BY reviewer

-- per ogni revisore, quante review hanno almeno un utente che le ha trovate utili
SELECT reviewer, COUNT(useful) as num_review
FROM review
WHERE useful > 0
GROUP BY reviewer

-- count(*) e count(<attributo>) restituiscono valori diversi quando sono presenti valori NULL su <attributo>


-- per ogni revisore restituire il numero di review. Considerare anche i revisori che non hanno effettuato alcuna review
-- i revisori che non hanno review devono comparire nel risultato con review_count = 0
-- join 
SELECT reviewer.id, count(*), count(reviewer)
FROM reviewer LEFT JOIN review ON reviewer.id = review.reviewer 
-- WHERE review.reviewer IS NULL
GROUP BY reviewer.id;


-- revisori che non hanno mai eseguito review
SELECT reviewer.id, name, review.*
FROM reviewer LEFT JOIN review ON reviewer.id = review.reviewer 
WHERE review.reviewer IS NULL;


with count_review as (
select reviewer, count(*) as num_review
from review 
group by reviewer
)
select reviewer, MAX(num_review)
FROM count_review

-- restituire i revisori che hanno recensito la stessa attività più di una volta
-- group by
SELECT reviewer, business, count(*)
FROM review r 
GROUP BY reviewer, business 
HAVING count(*) > 1

-- join
SELECT distinct r1.reviewer, r1.business 
FROM review r1, review r2
WHERE r1.reviewer = r2.reviewer AND r1.business = r2.business AND r1.review_date <> r2.review_date

-- trovare i reviewer con più di 10 review
SELECT reviewer, count(business)
FROM review
GROUP BY reviewer 
HAVING count(business) > 10

-- trovare i reviewer con più di 10 review che hanno almeno 3 stelle
SELECT reviewer, count(business)
FROM review
WHERE stars >=3
GROUP BY reviewer 
HAVING count(business) > 10

-- trovare le aziende che sono state valutate da 5 reviewer diversi
-- count distinct conta i valori distinti su un attributo considerato
SELECT business
FROM review 
GROUP BY business
HAVING count(distinct reviewer) = 5


-- trovare il revisore che ha una media stelle di review superiore alla media complessiva 
SELECT reviewer, AVG(stars)
FROM review
GROUP BY reviewer
HAVING AVG(stars) > (
SELECT AVG(stars)
FROM review)
ORDER BY 2


-- trovare la media complessiva delle stelle nelle review (considerando l'attributo stars)
-- a quale delle due opzioni a destra corrisponde AVG
SELECT AVG(stars), SUM(stars) / COUNT(stars), SUM(stars) / COUNT(*)
FROM review


-- restituire il nome del revisore che ha eseguito il maggior numero di recensioni
-- in SQL non è possibile fare aggregati di aggregati. Questa soluzione è errata:
SELECT MAX(COUNT(*))
FROM review r 
GROUP BY reviewer;
-- sviluppo corretto di questa query
-- raggruppo e conto le review di ogni revisore
-- trovo il conteggio massimo fra tutti i revisori
-- recupero i dati del revisore che ha il conteggio massimo
with count_reviewer as (
-- per ogni revisore, il numero di review
SELECT reviewer, count(*) as num_review
FROM review 
GROUP BY reviewer
), max_review as (
-- trovo il valore massimo di num_review fra tutti i revisori
SELECT MAX(num_review) as max_value
FROM count_reviewer
)
SELECT count_reviewer.*
FROM count_reviewer, max_review
WHERE num_review = max_value;

-- soluzione "pigra" e sbagliata quando più di un reviewer ha prodotto il valore massimo di review
SELECT reviewer, count(*) as num_review
FROM review 
GROUP BY reviewer
ORDER BY num_review DESC
LIMIT 1


-- restituire l'azienda che ha ricevuto il maggior numero di recensioni


-- trovare i business la cui media di valutazioni è sopra la media rispetto alla propria categoria di appartenenza
-- query correlata
SELECT business, avg(stars)
FROM review INNER JOIN incat i1 ON review.business = i1.business
GROUP BY business
HAVING avg(stars) > (

SELECT avg(review.stars)
FROM review INNER JOIN incat i2 ON review.business = i2.business
WHERE i2.category = i1.category
GROUP BY i2.category

)


