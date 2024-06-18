# Esercizi - continua la storia

# Un seconda richiesta dal sig. Libraio

> (1) Quando ho finito la catalogazione, apro bottega. Quando entra un cliente, questo può interpellarmi per varie ragioni: 
- o mi chiede direttamente un libro dicendomi i corrispondenti autore e titolo; 
- o mi chiede di suggerirgli qualche nuovo libro uscito quest’anno scritto da un certo autore;
- o mi chiede quali libri di un certo genere ed entro una certa fascia di prezzo potrebbe regalare per il compleanno del fratello. 

(2) Una novità che ho introdotto recentemente si chiama “Appuntamente al buio”: ogni settimana estraggo un libro a caso e lo vendo ad un prezzo fisso di 10 €. Questa soluzione è ottima per i più indecisi!

(3) Nel caso il cliente proceda con l’acquisto, devo aggiornare il registro libri e anche il conto cassa giornaliero. Alla fine della giornata, conto i guadagni e trasferisco tutto in cassaforte.
Ahimé, quanto lavoro… aiutatemi!
> 

Riesci ad accontentare il nostro cliente? L’intera richiesta è divisa in 3 esercizi. Puoi affrontarli nell’ordine che preferisci.

Potresti avere bisogno dei seguenti riferimenti per svolgere questi esercizi:

## Cercare per autore e anno corrente

- utilizzo datetime: [https://www.w3schools.com/python/python_datetime.asp](https://www.w3schools.com/python/python_datetime.asp)
- inserire prima un volume datato con l’anno corrente, altrimenti non avremo mai nessun risultato

## Cerca per genere e fascia di prezzo

- valori di default: [https://www.geeksforgeeks.org/default-arguments-in-python/](https://www.geeksforgeeks.org/default-arguments-in-python/)

## Estrai a caso un libro dalla collezione

- pacchetto `random` : [https://www.w3schools.com/python/module_random.asp](https://www.w3schools.com/python/module_random.asp)
- metodo `.keys()` dei dizionari

## Acquistare un libro

- Sollevare eccezioni: [https://www.w3schools.com/python/gloss_python_raise.asp](https://www.w3schools.com/python/gloss_python_raise.asp)
- `datetime.datetime.now().strftime("%d%m%Y")` : [https://www.w3schools.com/python/python_datetime.asp](https://www.w3schools.com/python/python_datetime.asp)