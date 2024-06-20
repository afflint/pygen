# Codice usato durante la lezione

# registro.py versione 0

```python
libro1 = ("Il nome della rosa", "Umberto Eco", 1980, "Romanzo Storico", 20.00, 5)
libro2 = ("1984", "George Orwell", 1949, "Distopico", 15.00, 10)
libro3 = ("Il Signore degli Anelli", "J.R.R. Tolkien", 1954, "Fantasy", 25.00, 3)
libro4 = ("La Guida Galattica per Autostoppisti", "Douglas Adams", 1979, "Fantascienza", 18.00, 7)

def stampa_dettagli_libro(libro):
    print(f"Titolo: {libro[0]}")
    print(f"Autore: {libro[1]}")
    print(f"Anno: {libro[2]}")
    print(f"Genere: {libro[3]}")
    print(f"Prezzo: {libro[4]}")
    print(f"Quantità: {libro[5]}")
    print("-----------------------")

def stampa_collezione():
    stampa_dettagli_libro(libro1)
    stampa_dettagli_libro(libro2)
    stampa_dettagli_libro(libro3)
    stampa_dettagli_libro(libro4)
```

# main.py versione 0

```python
import registro

registro.stampa_collezione()
```

# registro.py versione 1

- Aggiunta la funzione `aggiungi_libro`.
- La funzione prende come parametri i dettagli di un libro (titolo, autore, anno, genere, prezzo, quantità).
- La funzione restituisce una tupla contenente queste informazioni.

```python
libro1 = ("Il nome della rosa", "Umberto Eco", 1980, "Romanzo Storico", 20.00, 5)
libro2 = ("1984", "George Orwell", 1949, "Distopico", 15.00, 10)
libro3 = ("Il Signore degli Anelli", "J.R.R. Tolkien", 1954, "Fantasy", 25.00, 3)
libro4 = ("La Guida Galattica per Autostoppisti", "Douglas Adams", 1979, "Fantascienza", 18.00, 7)

def stampa_dettagli_libro(libro):
    print(f"Titolo: {libro[0]}")
    print(f"Autore: {libro[1]}")
    print(f"Anno: {libro[2]}")
    print(f"Genere: {libro[3]}")
    print(f"Prezzo: {libro[4]}")
    print(f"Quantità: {libro[5]}")
    print("-----------------------")

def stampa_collezione():
    stampa_dettagli_libro(libro1)
    stampa_dettagli_libro(libro2)
    stampa_dettagli_libro(libro3)
    stampa_dettagli_libro(libro4)
    print(f"Totale libri: {numero_libri}")

def aggiungi_libro(titolo, autore, anno, genere, prezzo, quantita):
    nuovo_libro = (titolo, autore, anno, genere, prezzo, quantita)
    return nuovo_libro
```

# main.py versione 1

- Aggiunta una chiamata a `registro.aggiungi_libro` per aggiungere un nuovo libro "Orgoglio e Pregiudizio" alla collezione.
- Aggiunta una seconda chiamata a `registro.stampa_collezione` per stampare la collezione aggiornata dopo l'aggiunta del nuovo libro.

```python
import registro

registro.stampa_collezione()
registro.aggiungi_libro("Orgoglio e Pregiudizio", "Jane Austen", 1813, "Romanzo", 14.00, 12)
registro.stampa_collezione()
```

# registro.py versione 2

- Aggiunta la lista `collezione` che contiene tutte le tuple dei libri (`libro1`, `libro2`, `libro3`, `libro4`).
- La funzione `aggiungi_libro` ora aggiunge il nuovo libro alla lista `collezione` utilizzando il metodo `append`.
- Rimossa la stampa della variabile `numero_libri` nella funzione `stampa_collezione`, poiché tale variabile non era definita.

```python
# registro.py v2
libro1 = ("Il nome della rosa", "Umberto Eco", 1980, "Romanzo Storico", 20.00, 5)
libro2 = ("1984", "George Orwell", 1949, "Distopico", 15.00, 10)
libro3 = ("Il Signore degli Anelli", "J.R.R. Tolkien", 1954, "Fantasy", 25.00, 3)
libro4 = ("La Guida Galattica per Autostoppisti", "Douglas Adams", 1979, "Fantascienza", 18.00, 7)
collezione = [libro1, libro2, libro3, libro4]
def stampa_dettagli_libro(libro):
    print(f"Titolo: {libro[0]}")
    print(f"Autore: {libro[1]}")
    print(f"Anno: {libro[2]}")
    print(f"Genere: {libro[3]}")
    print(f"Prezzo: {libro[4]}")
    print(f"Quantità: {libro[5]}")
    print("-----------------------")

def stampa_collezione():
    stampa_dettagli_libro(libro1)
    stampa_dettagli_libro(libro2)
    stampa_dettagli_libro(libro3)
    stampa_dettagli_libro(libro4)

def aggiungi_libro(titolo, autore, anno, genere, prezzo, quantita):
    nuovo_libro = (titolo, autore, anno, genere, prezzo, quantita)
    global collezione
    collezione.append(nuovo_libro)
```

# registro.py versione 3

- Convertito ciascun libro da tuple a liste per `libro1`, `libro2`, `libro3` e `libro4`.
- Aggiornato il parametro della funzione `stampa_collezione` per prendere in ingresso la lista `collezione`.
- Cambiato il tipo di dato per il nuovo libro creato in `aggiungi_libro` da tupla a lista.

```python
# registro.py v3

libro1 = list(("Il nome della rosa", "Umberto Eco", 1980, "Romanzo Storico", 20.00, 5))
libro2 = list(("1984", "George Orwell", 1949, "Distopico", 15.00, 10))
libro3 = list(("Il Signore degli Anelli", "J.R.R. Tolkien", 1954, "Fantasy", 25.00, 3))
libro4 = list(("La Guida Galattica per Autostoppisti", "Douglas Adams", 1979, "Fantascienza", 18.00, 7))
collezione = [libro1, libro2, libro3, libro4]
def stampa_dettagli_libro(libro):
    print(f"Titolo: {libro[0]}")
    print(f"Autore: {libro[1]}")
    print(f"Anno: {libro[2]}")
    print(f"Genere: {libro[3]}")
    print(f"Prezzo: {libro[4]}")
    print(f"Quantità: {libro[5]}")
    print("-----------------------")

def stampa_collezione(collezione):
    stampa_dettagli_libro(libro1)
    stampa_dettagli_libro(libro2)
    stampa_dettagli_libro(libro3)
    stampa_dettagli_libro(libro4)

def aggiungi_libro(titolo, autore, anno, genere, prezzo, quantita):
    nuovo_libro = [titolo, autore, anno, genere, prezzo, quantita]
    global collezione
    collezione.append(nuovo_libro)
```

# registro.py versione 4

- Aggiornata la funzione `stampa_collezione` per iterare attraverso la lista `collezione` e stampare i dettagli di ciascun libro utilizzando la funzione `stampa_dettagli_libro`.
- La lista `collezione` è ora passata come parametro alla funzione `stampa_collezione`.
- La struttura e la logica rimangono sostanzialmente invariate rispetto alla versione precedente, ma è stata aggiornata per utilizzare la lista `collezione` come argomento nella funzione `stampa_collezione`.

```python
# registro.py v4

libro1 = list(("Il nome della rosa", "Umberto Eco", 1980, "Romanzo Storico", 20.00, 5))
libro2 = list(("1984", "George Orwell", 1949, "Distopico", 15.00, 10))
libro3 = list(("Il Signore degli Anelli", "J.R.R. Tolkien", 1954, "Fantasy", 25.00, 3))
libro4 = list(("La Guida Galattica per Autostoppisti", "Douglas Adams", 1979, "Fantascienza", 18.00, 7))
collezione = [libro1, libro2, libro3, libro4]
def stampa_dettagli_libro(libro):
    print(f"Titolo: {libro[0]}")
    print(f"Autore: {libro[1]}")
    print(f"Anno: {libro[2]}")
    print(f"Genere: {libro[3]}")
    print(f"Prezzo: {libro[4]}")
    print(f"Quantità: {libro[5]}")
    print("-----------------------")

def stampa_collezione(collezione):
    for libro in collezione:
        stampa_dettagli_libro(libro)

def aggiungi_libro(titolo, autore, anno, genere, prezzo, quantita):
    nuovo_libro = [titolo, autore, anno, genere, prezzo, quantita]
    global collezione
    collezione.append(nuovo_libro)
```

# main.py versione 2

- Aggiornate le chiamate a `registro.stampa_collezione` per passare la lista `registro.collezione` come argomento.

```python
# main.py v2

import registro

registro.stampa_collezione(registro.collezione)

registro.aggiungi_libro("Orgoglio e Pregiudizio", "Jane Austen", 1813, "Romanzo", 14.00, 12)
registro.stampa_collezione(registro.collezione)

```

# main.py versione 3

- Aggiunta una sezione interattiva per chiedere all'utente se desidera inserire un nuovo libro.
- L'utente può rispondere con "s" per sì o "n" per no.
- Stampata a schermo la scelta dell'utente tramite la variabile `inserire_libro`.

```python
# main.py v3

import registro

print("Vuoi inserire un libro?")
inserire_libro = input("Sì (s) o no (n)?")
print(f"Hai scelto: {inserire_libro}") # stampiamo per far vedere la scelta
```

# main.py versione 4

- Aggiunta una condizione per verificare se l'utente ha scelto di inserire un libro (risposta "s").
- Utilizzata la funzione `lower()` per convertire la risposta dell'utente in minuscolo, permettendo così una corrispondenza non case-sensitive.
- Aggiunta una stampa che viene eseguita solo se l'utente ha scelto di inserire un libro.
- Aggiunta una stampa generica che viene eseguita sempre, indipendentemente dalla scelta dell'utente.

```python
# main.py v4

import registro

print("Vuoi inserire un libro?")
inserire_libro = input("Sì (s) o no (n)?")
print(f"Hai scelto: {inserire_libro}")

if inserire_libro.lower() == "s": # nota che qui abbiamo usato la funzione lower!
    print("Vuoi inserire un libro!")
 
print("Non vuoi inserire un libro? Peccato...")
```

# main.py versione 5

- Aggiunta una clausola `else` per gestire il caso in cui l'utente non desidera inserire un libro (risposta diversa da "s").
- Stampata una frase appropriata per indicare che l'utente ha scelto di non inserire un libro.
- La logica complessiva rimane simile alla versione precedente, ma è stata aggiunta la gestione dell'alternativa alla scelta di inserire un libro.

```python
# main.py v5

import registro

print("Vuoi inserire un libro?")
inserire_libro = input("Sì (s) o no (n)?")
print(f"Hai scelto: {inserire_libro}")

if inserire_libro.lower() == "s":
    print("Vuoi inserire un libro!")
else:
    print("Non vuoi inserire un libro? Peccato...")
```

# main.py versione 6

- Aggiunta una clausola `elif` per gestire il caso in cui l'utente inserisce una risposta diversa sia da "s" che da "n".
- Aggiunta una stampa che informa l'utente nel caso in cui la risposta non sia chiaramente "s" (sì) o "n" (no).
- Questa modifica migliora la gestione delle risposte dell'utente, fornendo una risposta appropriata anche nel caso in cui l'input non sia valido.

```python
# main.py v6

import registro

print("Vuoi inserire un libro?")
inserire_libro = input("Sì (s) o no (n)?")
print(f"Hai scelto: {inserire_libro}")

if inserire_libro.lower() == "s":
    print("Vuoi inserire un libro!")
elif inserire_libro.lower() == "n":
    print("Non vuoi inserire un libro? Peccato...")
else:
    print("Non sono sicuro che tu abbia premuto il tasto giusto.")
```

# main.py versione 7

- Aggiunta una sezione interattiva per chiedere all'utente se desidera visualizzare la collezione dopo aver gestito l'aggiunta di un libro.
- Aggiunta una serie di input per raccogliere le informazioni relative al nuovo libro se l'utente sceglie di inserirne uno.
- Utilizzato il metodo `strip()` per rimuovere eventuali spazi bianchi extra intorno alla risposta dell'utente.
- Aggiunte condizioni per gestire la scelta dell'utente di visualizzare o meno la collezione, stampando la collezione se la risposta è "s" e dando un messaggio appropriato se la risposta è "n".

```python
# main.py v7

import registro

print("Vuoi inserire un libro?")
inserire_libro = input("Sì (s) o no (n)?")
print(f"Hai scelto: {inserire_libro}")

if inserire_libro.lower().strip() == "s":
    print("Vuoi inserire un libro!")
    titolo_libro = input("Inserisci il titolo del libro: ")
    autore_libro = input("Inserisci l'autore del libro: ")
    anno_libro = int(input("Inserisci l'anno di pubblicazione del libro: "))
    genere_libro = input("Inserisci il genere del libro: ")
    prezzo_libro = float(input("Inserisci il prezzo del libro: "))
    quantita_libro = int(input("Inserisci il numero di volumi: "))
    registro.aggiungi_libro(titolo_libro, autore_libro, anno_libro, genere_libro, prezzo_libro, quantita_libro)
elif inserire_libro.lower().strip() == "n":
    print("Non vuoi inserire un libro? Peccato...")
else:
    print("Non sono sicuro che tu abbia premuto il tasto giusto.")

print("Vuoi visualizzare la collezione?")
visualizzare_collezione = input("Sì (s) o no (n)?")
print(f"Hai scelto: {visualizzare_collezione}")

if visualizzare_collezione.lower().strip() == "s":
    registro.stampa_collezione(registro.collezione)
elif inserire_libro.lower().strip() == "n":
    print("Non vuoi visualizzare la collezione? Peccato...")
else:
    print("Non sono sicuro che tu abbia premuto il tasto giusto.")
```

# main.py versione 8

- Aggiunta la gestione degli errori tramite blocchi `try-except` per catturare eccezioni durante l'inserimento dell'anno di pubblicazione, del prezzo e della quantità di libri.
- In caso di errore, viene stampato un messaggio specifico e richiesto all'utente di reinserire il dato correttamente.
- Questo miglioramento assicura che il programma gestisca correttamente situazioni in cui l'utente inserisce input non valido per anno, prezzo o quantità.

```python
# main.py v8

import registro

print("Vuoi inserire un libro?")
inserire_libro = input("Sì (s) o no (n)?")
print(f"Hai scelto: {inserire_libro}")

if inserire_libro.lower().strip() == "s":
    print("Vuoi inserire un libro!")
    titolo_libro = input("Inserisci il titolo del libro: ")
    autore_libro = input("Inserisci l'autore del libro: ")
    try:
        anno_libro = int(input("Inserisci l'anno di pubblicazione del libro: "))
    except:
        print("Non hai inserito un numero. Inserisci l'anno in formato numerico, ad esempio: 1993")
        anno_libro = int(
            input("Inserisci l'anno di pubblicazione del libro: ")) # se questo secondo tentativo va in errore, il programma dà errore e siamo punto a capo
    genere_libro = input("Inserisci il genere del libro: ")
    try:
        prezzo_libro = float(input("Inserisci il prezzo del libro: "))
    except:
        print("Non hai inserito un numero decimale. Inserisci il prezzo in formato numerico, ad esempio: 14.0")
        prezzo_libro = float(input("Inserisci il prezzo del libro: "))
    try:
        quantita_libro = int(input("Inserisci il numero di volumi: "))
    except:
        print("Non hai inserito un numero. Inserisci la quantità in formato numerico, ad esempio: 13")
        quantita_libro = int(input("Inserisci il numero di volumi: "))
    registro.aggiungi_libro(titolo_libro, autore_libro, anno_libro, genere_libro, prezzo_libro, quantita_libro)
elif inserire_libro.lower().strip() == "n":
    print("Non vuoi inserire un libro? Peccato...")
else:
    print("Non sono sicuro che tu abbia premuto il tasto giusto.")

print("Vuoi visualizzare la collezione?")
visualizzare_collezione = input("Sì (s) o no (n)?")
print(f"Hai scelto: {visualizzare_collezione}")

if visualizzare_collezione.lower().strip() == "s":
    registro.stampa_collezione(registro.collezione)
elif inserire_libro.lower().strip() == "n":
    print("Non vuoi visualizzare la collezione? Peccato...")
else:
    print("Non sono sicuro che tu abbia premuto il tasto giusto.")
```

# main.py versione 9

- Introdotta un'interfaccia a menu che consente all'utente di selezionare tra tre opzioni: inserire un nuovo libro, visualizzare la lista dei libri nel registro, o uscire dal programma.
- Utilizzato un ciclo `while` con la variabile `ripeti` per permettere al programma di continuare fino a quando l'utente sceglie di uscire.
- Ogni opzione nel menu è gestita da un blocco condizionale (`if-elif-else`) che esegue le azioni appropriate in base alla scelta dell'utente.
- Implementata la gestione degli errori durante l'inserimento dell'anno di pubblicazione, del prezzo e della quantità di libri, come nelle versioni precedenti.

```python
# main.py v9
import registro

ripeti = True
while ripeti:
    # menu
    print("Scegli una delle seguenti voci digitando il carattere corrispondente.")
    print("[i] Inserire un nuovo libro.")
    print("[v] Visualizzare la lista dei libri nel registro.")
    print("[e] Esci dal programma.")
    scelta = input("Digita la tua scelta tra i caratteri ammessi: ").lower().strip()

    # comportarsi di conseguenza a ciò che ha scelto l'utente

    # inserimento nuovo libro
    if scelta == "i":
        print("Vuoi inserire un libro!")
        titolo_libro = input("Inserisci il titolo del libro: ")
        autore_libro = input("Inserisci l'autore del libro: ")
        try:
            anno_libro = int(input("Inserisci l'anno di pubblicazione del libro: "))
        except:
            print("Non hai inserito un numero. Inserisci l'anno in formato numerico, ad esempio: 1993")
            anno_libro = int(
                input("Inserisci l'anno di pubblicazione del libro: ")) # se questo secondo tentativo va in errore, il programma dà errore e siamo punto a capo
        genere_libro = input("Inserisci il genere del libro: ")
        try:
            prezzo_libro = float(input("Inserisci il prezzo del libro: "))
        except:
            print("Non hai inserito un numero decimale. Inserisci il prezzo in formato numerico, ad esempio: 14.0")
            prezzo_libro = float(input("Inserisci il prezzo del libro: "))
        try:
            quantita_libro = int(input("Inserisci il numero di volumi: "))
        except:
            print("Non hai inserito un numero. Inserisci la quantità in formato numerico, ad esempio: 13")
            quantita_libro = int(input("Inserisci il numero di volumi: "))
        registro.aggiungi_libro(titolo_libro, autore_libro, anno_libro, genere_libro, prezzo_libro, quantita_libro)

    # visualizzazione registro
    elif scelta == "v":
        print("Vuoi visualizzare il registro!")
        registro.stampa_collezione(registro.collezione)

    # uscita dal programma
    elif scelta == "e":
        print("Alla prossima!")
        ripeti = False
    else:
        print("Sembra che tu abbia scelto qualcosa che non esiste nel menu. Per favore, digita una delle opzioni presenti nel menu")

```

# registro.py versione 5

- Aggiunta l'importazione dei moduli `os` e `pickle` per gestire operazioni di sistema e serializzazione.
- Aggiunta la funzione `salva_collezione()` che serializza la lista `collezione` utilizzando `pickle` e salva il risultato in un file chiamato `collezione.pkl` nella directory `data`.
- Verifica se la cartella `data` esiste; se non esiste, la crea prima di salvare il file.
- Questa versione introduce la capacità di salvare la collezione di libri in un file binario utilizzando `pickle`, consentendo così di conservare i dati tra esecuzioni del programma.

```python
# registro.py v5

import os
import pickle

libro1 = list(("Il nome della rosa", "Umberto Eco", 1980, "Romanzo Storico", 20.00, 5))
libro2 = list(("1984", "George Orwell", 1949, "Distopico", 15.00, 10))
libro3 = list(("Il Signore degli Anelli", "J.R.R. Tolkien", 1954, "Fantasy", 25.00, 3))
libro4 = list(("La Guida Galattica per Autostoppisti", "Douglas Adams", 1979, "Fantascienza", 18.00, 7))
collezione = [libro1, libro2, libro3, libro4]
def stampa_dettagli_libro(libro):
    print(f"Titolo: {libro[0]}")
    print(f"Autore: {libro[1]}")
    print(f"Anno: {libro[2]}")
    print(f"Genere: {libro[3]}")
    print(f"Prezzo: {libro[4]}")
    print(f"Quantità: {libro[5]}")
    print("-----------------------")

def stampa_collezione(collezione):
    for libro in collezione:
        stampa_dettagli_libro(libro)

def aggiungi_libro(titolo, autore, anno, genere, prezzo, quantita):
    nuovo_libro = [titolo, autore, anno, genere, prezzo, quantita]
    global collezione
    collezione.append(nuovo_libro)

def salva_collezione():
    global collezione
    if not os.path.exists("data"):
        # creiamo la cartella data nella posizione corrente se non esiste già
        os.makedirs("data")
    with open(os.path.join("data","collezione.pkl"), "wb") as file:
        pickle.dump(collezione, file) # salviamo il file
```

# main.py versione 10

- Aggiunto il salvataggio automatico della collezione di libri utilizzando la funzione `salva_collezione()` del modulo `registro` al momento dell'uscita dal programma (`scelta == "e"`).
- Prima di uscire dal programma, viene chiamata la funzione `registro.salva_collezione()` per serializzare la collezione corrente e salvarla nel file `collezione.pkl`.
- Questo garantisce che tutte le modifiche alla collezione di libri siano salvate prima di chiudere l'applicazione, permettendo di ripristinare lo stato precedente al successivo avvio.

```python
# main.py v10

import registro

ripeti = True
while ripeti:
    # menu
    print("Scegli una delle seguenti voci digitando il carattere corrispondente.")
    print("[i] Inserire un nuovo libro.")
    print("[v] Visualizzare la lista dei libri nel registro.")
    print("[e] Esci dal programma.")
    scelta = input("Digita la tua scelta tra i caratteri ammessi: ").lower().strip()

    # comportarsi di conseguenza a ciò che ha scelto l'utente

    # inserimento nuovo libro
    if scelta == "i":
        print("Vuoi inserire un libro!")
        titolo_libro = input("Inserisci il titolo del libro: ")
        autore_libro = input("Inserisci l'autore del libro: ")
        try:
            anno_libro = int(input("Inserisci l'anno di pubblicazione del libro: "))
        except:
            print("Non hai inserito un numero. Inserisci l'anno in formato numerico, ad esempio: 1993")
            anno_libro = int(
                input("Inserisci l'anno di pubblicazione del libro: ")) # se questo secondo tentativo va in errore, il programma dà errore e siamo punto a capo
        genere_libro = input("Inserisci il genere del libro: ")
        try:
            prezzo_libro = float(input("Inserisci il prezzo del libro: "))
        except:
            print("Non hai inserito un numero decimale. Inserisci il prezzo in formato numerico, ad esempio: 14.0")
            prezzo_libro = float(input("Inserisci il prezzo del libro: "))
        try:
            quantita_libro = int(input("Inserisci il numero di volumi: "))
        except:
            print("Non hai inserito un numero. Inserisci la quantità in formato numerico, ad esempio: 13")
            quantita_libro = int(input("Inserisci il numero di volumi: "))
        registro.aggiungi_libro(titolo_libro, autore_libro, anno_libro, genere_libro, prezzo_libro, quantita_libro)

    # visualizzazione registro
    elif scelta == "v":
        print("Vuoi visualizzare il registro!")
        registro.stampa_collezione(registro.collezione)

    # uscita dal programma
    elif scelta == "e":
        print("Alla prossima!")
        ripeti = False
        registro.salva_collezione() # salviamo la collezione prima di uscire
    else:
        print("Sembra che tu abbia scelto qualcosa che non esiste nel menu. Per favore, digita una delle opzioni presenti nel menu")

```

# registro.py versione 6

- Aggiunta gestione del caricamento della collezione da file utilizzando `pickle`.
- Nel nuovo codice, la collezione di libri viene caricata dal file `collezione.pkl` all'avvio del programma.
- Se il file esiste e contiene dati validi, la collezione viene caricata correttamente; altrimenti, se il file non esiste o è corrotto, viene inizializzata una nuova collezione vuota.
- Questo approccio consente di mantenere la persistenza dei dati tra le esecuzioni del programma, ripristinando lo stato precedente della collezione di libri.

Questo codice migliora l'applicazione aggiungendo la capacità di caricare e salvare automaticamente la collezione di libri da e su un file di salvataggio (`collezione.pkl`).

```python
# registro.py v6

import os
import pickle

try:
    with open(os.path.join("data","collezione.pkl"), "rb") as file:
        collezione = pickle.load(file)
except:
    print("File di salvataggio non trovato")
    collezione = []

def stampa_dettagli_libro(libro):
    print(f"Titolo: {libro[0]}")
    print(f"Autore: {libro[1]}")
    print(f"Anno: {libro[2]}")
    print(f"Genere: {libro[3]}")
    print(f"Prezzo: {libro[4]}")
    print(f"Quantità: {libro[5]}")
    print("-----------------------")

def stampa_collezione(collezione):
    for libro in collezione:
        stampa_dettagli_libro(libro)

def aggiungi_libro(titolo, autore, anno, genere, prezzo, quantita):
    nuovo_libro = [titolo, autore, anno, genere, prezzo, quantita]
    global collezione
    collezione.append(nuovo_libro)

def salva_collezione():
    global collezione
    if not os.path.exists("data"):
        # creiamo la cartella data nella posizione corrente se non esiste già
        os.makedirs("data")
    with open(os.path.join("data","collezione.pkl"), "wb") as file:
        pickle.dump(collezione, file) # salviamo il file
```

# registro.py versione 7

- Aggiunta della funzione `modifica_libro` per consentire la modifica di campi specifici di un libro nella collezione.
- Questa funzione prende in input il titolo del libro da modificare, il campo da modificare e il nuovo valore da assegnare.
- Scorre la collezione di libri fino a trovare il libro corrispondente al titolo specificato.
- Una volta trovato il libro, controlla quale campo deve essere modificato utilizzando un carattere identificativo (`s` per autore, `a` per anno, `g` per genere, `p` per prezzo, `q` per quantità).
- Dopo aver effettuato la modifica, stampa i dettagli aggiornati del libro.
- Se il titolo del libro non è trovato nella collezione, la funzione non esegue alcuna modifica e restituisce un messaggio di avviso.

Questa aggiunta permette di gestire la modifica selettiva dei dati dei libri nella collezione, aumentando la flessibilità e la gestione dell'archiviazione dei dati nel sistema.

```python
# registro.py v7
import os
import pickle

try:
    with open(os.path.join("data","collezione.pkl"), "rb") as file:
        collezione = pickle.load(file)
except:
    print("File di salvataggio non trovato")
    collezione = []

def stampa_dettagli_libro(libro):
    print(f"Titolo: {libro[0]}")
    print(f"Autore: {libro[1]}")
    print(f"Anno: {libro[2]}")
    print(f"Genere: {libro[3]}")
    print(f"Prezzo: {libro[4]}")
    print(f"Quantità: {libro[5]}")
    print("-----------------------")

def stampa_collezione(collezione):
    for libro in collezione:
        stampa_dettagli_libro(libro)

def aggiungi_libro(titolo, autore, anno, genere, prezzo, quantita):
    nuovo_libro = [titolo, autore, anno, genere, prezzo, quantita]
    global collezione
    collezione.append(nuovo_libro)

def salva_collezione():
    global collezione
    if not os.path.exists("data"):
        # creiamo la cartella data nella posizione corrente se non esiste già
        os.makedirs("data")
    with open(os.path.join("data","collezione.pkl"), "wb") as file:
        pickle.dump(collezione, file) # salviamo il file

def modifica_libro(titolo_libro, campo_da_modificare, nuovo_valore):
    global collezione
    for libro in collezione:
        if libro[0] == titolo_libro:
            if campo_da_modificare == "s":
                libro[1] = nuovo_valore
            elif campo_da_modificare == "a":
                libro[2] = nuovo_valore
            elif campo_da_modificare == "g":
                libro[3] = nuovo_valore
            elif campo_da_modificare == "p":
                libro[4] = nuovo_valore
            elif campo_da_modificare == "q":
                libro[5] = nuovo_valore
            print("Libro modificato! Ecco le modifiche riportate:")
            stampa_dettagli_libro(libro)
            return # usciamo subito dalla funzione!
```

# main.py versione 11

1. **Menu Esteso:** Aggiunta dell'opzione per modificare una voce nel registro (`m`).
2. **Gestione della Modifica:** Implementata la gestione della modifica per autore, anno di pubblicazione, genere, prezzo e quantità di un libro esistente.
3. **Funzione di Salvataggio:** Prima di uscire dal programma (`e`), viene salvata la collezione aggiornata utilizzando `registro.salva_collezione()`.

Queste modifiche estendono la funzionalità del programma consentendo agli utenti di aggiornare informazioni esistenti nella collezione di libri in modo interattivo.

```python
# main.py v11
import registro

ripeti = True
while ripeti:
    # menu
    print("Scegli una delle seguenti voci digitando il carattere corrispondente.")
    print("[i] Inserire un nuovo libro.")
    print("[v] Visualizzare la lista dei libri nel registro.")
    print("[m] Modificare una voce nel registro.")
    print("[e] Esci dal programma.")
    scelta = input("Digita la tua scelta tra i caratteri ammessi: ").lower().strip()

    # comportarsi di conseguenza a ciò che ha scelto l'utente

    # inserimento nuovo libro
    if scelta == "i":
        print("Vuoi inserire un libro!")
        titolo_libro = input("Inserisci il titolo del libro: ")
        autore_libro = input("Inserisci l'autore del libro: ")
        try:
            anno_libro = int(input("Inserisci l'anno di pubblicazione del libro: "))
        except:
            print("Non hai inserito un numero. Inserisci l'anno in formato numerico, ad esempio: 1993")
            anno_libro = int(
                input("Inserisci l'anno di pubblicazione del libro: ")) # se questo secondo tentativo va in errore, il programma dà errore e siamo punto a capo
        genere_libro = input("Inserisci il genere del libro: ")
        try:
            prezzo_libro = float(input("Inserisci il prezzo del libro: "))
        except:
            print("Non hai inserito un numero decimale. Inserisci il prezzo in formato numerico, ad esempio: 14.0")
            prezzo_libro = float(input("Inserisci il prezzo del libro: "))
        try:
            quantita_libro = int(input("Inserisci il numero di volumi: "))
        except:
            print("Non hai inserito un numero. Inserisci la quantità in formato numerico, ad esempio: 13")
            quantita_libro = int(input("Inserisci il numero di volumi: "))
        registro.aggiungi_libro(titolo_libro, autore_libro, anno_libro, genere_libro, prezzo_libro, quantita_libro)

    # visualizzazione registro
    elif scelta == "v":
        print("Vuoi visualizzare il registro!")
        registro.stampa_collezione(registro.collezione)

    elif scelta == "m":
        print("Vuoi modificare una voce nel registro!")
        titolo_libro_da_modificare = input("Inserisci il titolo del libro da modificare: ")
        print("Quale informazione vuoi modificare? Scegli tra:")
        print("[s] Autore")
        print("[a] Anno di pubblicazione")
        print("[g] Genere")
        print("[p] Prezzo")
        print("[q] Quantità")
        scelta_modifica = input("Digita la tua scelta tra i caratteri ammessi: ").lower().strip()
        if scelta_modifica == "s":
            nuovo_autore = input("Inserisci un nuovo autore: ")
            registro.modifica_libro(titolo_libro_da_modificare, "s", nuovo_autore)
        elif scelta_modifica == "a":
            try:
                nuovo_anno = int(input("Inserisci un nuovo anno di pubblicazione: "))
            except:
                print(
                    "Non hai inserito un numero. Inserisci l'anno in formato numerico, ad esempio: 1993")
                nuovo_anno = int(
                    input(
                        "Inserisci l'anno di pubblicazione del libro: "))  # se questo secondo tentativo va in errore, il programma dà errore e siamo punto a capo
            registro.modifica_libro(titolo_libro_da_modificare, "a", nuovo_anno)
        elif scelta_modifica == "g":
            nuovo_genere = input("Inserisci un nuovo genere: ")
            registro.modifica_libro(titolo_libro_da_modificare, "g",
                                    nuovo_genere)
        elif scelta_modifica == "p":
            try:
                nuovo_prezzo = float(input("Inserisci un nuovo prezzo: "))
            except:
                print(
                    "Non hai inserito un numero. Inserisci il prezzo in formato numerico, ad esempio: 14.0")
                nuovo_prezzo = float(
                    input(
                        "Inserisci un nuovo prezzo: "))  # se questo secondo tentativo va in errore, il programma dà errore e siamo punto a capo
            registro.modifica_libro(titolo_libro_da_modificare, "p", nuovo_prezzo)
        elif scelta_modifica == "q":
            try:
                nuova_quantita = int(input("Inserisci un nuova quantità: "))
            except:
                print(
                    "Non hai inserito un numero. Inserisci la quantità in formato numerico, ad esempio: 13")
                nuova_quantita = int(
                    input(
                        "Inserisci l'anno di pubblicazione del libro: "))  # se questo secondo tentativo va in errore, il programma dà errore e siamo punto a capo
            registro.modifica_libro(titolo_libro_da_modificare, "q", nuova_quantita)
        else:
            print("Sembra che tu abbia scelto qualcosa che non esiste nel menu.")

    # uscita dal programma
    elif scelta == "e":
        print("Alla prossima!")
        ripeti = False
        registro.salva_collezione()
    else:
        print("Sembra che tu abbia scelto qualcosa che non esiste nel menu. Per favore, digita una delle opzioni presenti nel menu")
```

# registro.py versione 8

- **Struttura della Collezione:** La collezione dei libri è stata gestita come un dizionario anziché una lista. Se il file di salvataggio contiene una lista, viene convertita in un dizionario, dove ogni libro è associato a un indice numerico.
- **Funzionalità Aggiornate:**
    - **Stampa della Collezione:** `stampa_collezione` è stata adattata per iterare sui valori del dizionario `collezione`.
    - **Stampa con Codice:** Aggiunta la funzione `stampa_collezione_con_codice` che stampa ogni libro con un codice numerico.
    - **Aggiunta Libro:** `aggiungi_libro` assegna un nuovo libro al dizionario `collezione` utilizzando un indice numerico incrementale.
    - **Modifica Libro:** `modifica_libro` permette di modificare un libro specificato tramite il suo codice numerico, aggiornando il campo specificato con il nuovo valore.
- **Gestione degli Errori:** Gestione dell'eccezione `KeyError` nel caso in cui il codice libro specificato per la modifica non esista nella collezione.

```python
#registro.py v8
import os
import pickle

try:
    with open(os.path.join("data","collezione.pkl"), "rb") as file:
        collezione_lista = pickle.load(file)
        if type(collezione_lista) != dict:
            collezione = {}
            # aggiungiamo i codici
            for indice, libro in enumerate(collezione_lista):
                collezione[indice] = libro
        else:
            collezione = collezione_lista

except:
    print("File di salvataggio non trovato")
    collezione = {}

def stampa_dettagli_libro(libro):
    print(f"Titolo: {libro[0]}")
    print(f"Autore: {libro[1]}")
    print(f"Anno: {libro[2]}")
    print(f"Genere: {libro[3]}")
    print(f"Prezzo: {libro[4]}")
    print(f"Quantità: {libro[5]}")
    print("-----------------------")

def stampa_collezione():
    global collezione
    for libro in collezione.values():
        stampa_dettagli_libro(libro)

def stampa_collezione_con_codice():
    global collezione
    for indice, libro in collezione.items():
        print(f"[{indice}] {libro[0]}, {libro[1]}, {libro[2]}, {libro[3]}, {libro[4]}, {libro[5]}")

def aggiungi_libro(titolo, autore, anno, genere, prezzo, quantita):
    nuovo_libro = [titolo, autore, anno, genere, prezzo, quantita]
    global collezione
    indice = len(collezione)
    collezione[indice] = nuovo_libro

def salva_collezione():
    global collezione
    if not os.path.exists("data"):
        # creiamo la cartella data nella posizione corrente se non esiste già
        os.makedirs("data")
    with open(os.path.join("data","collezione.pkl"), "wb") as file:
        pickle.dump(collezione, file) # salviamo il file

def modifica_libro(codice_libro, campo_da_modificare, nuovo_valore):
    global collezione
    try:
        if campo_da_modificare == "s":
            collezione[codice_libro][1] = nuovo_valore
        elif campo_da_modificare == "a":
            collezione[codice_libro][2] = nuovo_valore
        elif campo_da_modificare == "g":
            collezione[codice_libro][3] = nuovo_valore
        elif campo_da_modificare == "p":
            collezione[codice_libro][4] = nuovo_valore
        elif campo_da_modificare == "q":
            collezione[codice_libro][5] = nuovo_valore
        print("Libro modificato! Ecco le modifiche riportate:")
        stampa_dettagli_libro(collezione[codice_libro])
    except KeyError:
        print(f"Il codice {codice_libro} non esiste")
```

# main.py versione 12

- **Aggiunta della Funzione Modifica:**
    - È stata aggiunta una nuova opzione di menu (`m`) per modificare un libro esistente nel registro.
- **Implementazione della Modifica:**
    - Quando l'utente sceglie di modificare un libro, viene prima stampata la lista dei libri con i loro codici numerici utilizzando la funzione `stampa_collezione_con_codice` da `registro.py`.
    - L'utente può quindi selezionare il libro da modificare specificando il codice numerico.
    - Viene chiesto quale campo del libro si desidera modificare (autore, anno, genere, prezzo, quantità).
    - Vengono gestiti casi specifici se l'utente non inserisce un numero valido per il codice del libro o per i valori numerici da modificare.
- **Miglioramenti nella Gestione dell'Input:**
    - L'input dell'utente è gestito in modo più robusto con controlli aggiuntivi per assicurarsi che l'utente fornisca input valido.

```python
# main.py v12
import registro

ripeti = True
while ripeti:
    # menu
    print("Scegli una delle seguenti voci digitando il carattere corrispondente.")
    print("[i] Inserire un nuovo libro.")
    print("[v] Visualizzare la lista dei libri nel registro.")
    print("[m] Modificare una voce nel registro.")
    print("[e] Esci dal programma.")
    scelta = input("Digita la tua scelta tra i caratteri ammessi: ").lower().strip()

    # comportarsi di conseguenza a ciò che ha scelto l'utente

    # inserimento nuovo libro
    if scelta == "i":
        print("Vuoi inserire un libro!")
        titolo_libro = input("Inserisci il titolo del libro: ")
        autore_libro = input("Inserisci l'autore del libro: ")
        try:
            anno_libro = int(input("Inserisci l'anno di pubblicazione del libro: "))
        except:
            print("Non hai inserito un numero. Inserisci l'anno in formato numerico, ad esempio: 1993")
            anno_libro = int(
                input("Inserisci l'anno di pubblicazione del libro: ")) # se questo secondo tentativo va in errore, il programma dà errore e siamo punto a capo
        genere_libro = input("Inserisci il genere del libro: ")
        try:
            prezzo_libro = float(input("Inserisci il prezzo del libro: "))
        except:
            print("Non hai inserito un numero decimale. Inserisci il prezzo in formato numerico, ad esempio: 14.0")
            prezzo_libro = float(input("Inserisci il prezzo del libro: "))
        try:
            quantita_libro = int(input("Inserisci il numero di volumi: "))
        except:
            print("Non hai inserito un numero. Inserisci la quantità in formato numerico, ad esempio: 13")
            quantita_libro = int(input("Inserisci il numero di volumi: "))
        registro.aggiungi_libro(titolo_libro, autore_libro, anno_libro, genere_libro, prezzo_libro, quantita_libro)

    # visualizzazione registro
    elif scelta == "v":
        print("Vuoi visualizzare il registro!")
        registro.stampa_collezione()

    elif scelta == "m":
        print("Vuoi modificare una voce nel registro!")
        registro.stampa_collezione_con_codice()
        try:
            codice_libro_da_modificare = int(input("Inserisci il codice del libro da modificare: "))
        except:
            print(
                "Non hai inserito un numero. Inserisci uno dei codici numeri mostrati di sopra.")
            codice_libro_da_modificare = int(
                input("Inserisci il codice del libro da modificare: "))
        print("Quale informazione vuoi modificare? Scegli tra:")
        print("[s] Autore")
        print("[a] Anno di pubblicazione")
        print("[g] Genere")
        print("[p] Prezzo")
        print("[q] Quantità")
        scelta_modifica = input("Digita la tua scelta tra i caratteri ammessi: ").lower().strip()
        if scelta_modifica == "s":
            nuovo_autore = input("Inserisci un nuovo autore: ")
            registro.modifica_libro(codice_libro_da_modificare, "s", nuovo_autore)
        elif scelta_modifica == "a":
            try:
                nuovo_anno = int(input("Inserisci un nuovo anno di pubblicazione: "))
            except:
                print(
                    "Non hai inserito un numero. Inserisci l'anno in formato numerico, ad esempio: 1993")
                nuovo_anno = int(
                    input(
                        "Inserisci l'anno di pubblicazione del libro: "))  # se questo secondo tentativo va in errore, il programma dà errore e siamo punto a capo
            registro.modifica_libro(codice_libro_da_modificare, "a", nuovo_anno)
        elif scelta_modifica == "g":
            nuovo_genere = input("Inserisci un nuovo genere: ")
            registro.modifica_libro(codice_libro_da_modificare, "g",
                                    nuovo_genere)
        elif scelta_modifica == "p":
            try:
                nuovo_prezzo = float(input("Inserisci un nuovo prezzo: "))
            except:
                print(
                    "Non hai inserito un numero. Inserisci il prezzo in formato numerico, ad esempio: 14.0")
                nuovo_prezzo = float(
                    input(
                        "Inserisci un nuovo prezzo: "))  # se questo secondo tentativo va in errore, il programma dà errore e siamo punto a capo
            registro.modifica_libro(codice_libro_da_modificare, "p", nuovo_prezzo)
        elif scelta_modifica == "q":
            try:
                nuova_quantita = int(input("Inserisci un nuova quantità: "))
            except:
                print(
                    "Non hai inserito un numero. Inserisci la quantità in formato numerico, ad esempio: 13")
                nuova_quantita = int(
                    input(
                        "Inserisci l'anno di pubblicazione del libro: "))  # se questo secondo tentativo va in errore, il programma dà errore e siamo punto a capo
            registro.modifica_libro(codice_libro_da_modificare, "q", nuova_quantita)
        else:
            print("Sembra che tu abbia scelto qualcosa che non esiste nel menu.")

    # uscita dal programma
    elif scelta == "e":
        print("Alla prossima!")
        ripeti = False
        registro.salva_collezione()
    else:
        print("Sembra che tu abbia scelto qualcosa che non esiste nel menu. Per favore, digita una delle opzioni presenti nel menu")
```
