# Soluzioni

# Un seconda richiesta dal sig. Libraio

> Quando ho finito la catalogazione, apro bottega. Quando entra un cliente, questo può interpellarmi per varie ragioni: o mi chiede direttamente un libro dicendomi i corrispondenti autore e titolo; o mi chiede di suggerirgli qualche nuovo libro uscito quest’anno scritto da un certo autore; o mi chiede quali libri di un certo genere ed entro una certa fascia di prezzo potrebbe regalare per il compleanno del fratello. Una novità che ho introdotto recentemente si chiama “Appuntamente al buio”: ogni settimana estraggo un libro a caso e lo vendo ad un prezzo fisso di 10 €. Questa soluzione è ottima per i più indecisi!
Nel caso il cliente proceda con l’acquisto, devo aggiornare il registro libri e anche il conto cassa giornaliero. Alla fine della giornata, conto i guadagni e trasferisco tutto in cassaforte.
Ahimé, quanto lavoro… aiutatemi!
> 

Riesci ad accontentare il nostro cliente?

## Cercare per titolo e autore

```python
# registro.py

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

def cerca_titolo_autore(titolo, autore):
    global collezione
    risultati_ricerca = []
    for indice, libro in collezione.items():
        if libro[0].lower().strip() == titolo.lower().strip():
            # per ogni nome e cognome, controllare le corrispondenze
            nomi_cognomi = autore.split(" ")
            corrispondenza_autore = True
            for n in nomi_cognomi:
                if n not in libro[1].lower().strip():
                    corrispondenza_autore = False
            if corrispondenza_autore:
                risultati_ricerca.append((indice, libro))
    return risultati_ricerca

```

```python
# main.py

import registro

ripeti = True
while ripeti:
    # menu
    print("Scegli una delle seguenti voci digitando il carattere corrispondente.")
    print("[i] Inserire un nuovo libro.")
    print("[v] Visualizzare la lista dei libri nel registro.")
    print("[m] Modificare una voce nel registro.")
    print("[c] Cerca.")
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

    elif scelta == "c":
        print("Come vorresti cercare?")
        print("[1] Per titolo e autore")
        scelta_cerca = input("Digita la tua scelta tra i caratteri ammessi: ").lower().strip()
        if scelta_cerca == "1":
            titolo_cerca = input("Inserisci il titolo del libro: ")
            autore_cerca = input("Inserisci l'autore del libro: ")
            risultato_ricerca = registro.cerca_titolo_autore(titolo_cerca, autore_cerca)
            if risultato_ricerca:
                for r in risultato_ricerca:
                    print(f"[{r[0]}]: {r[1]}")
            else:
                print("Nessun risultato trovato!")
    # uscita dal programma
    elif scelta == "e":
        print("Alla prossima!")
        ripeti = False
        registro.salva_collezione()
    else:
        print("Sembra che tu abbia scelto qualcosa che non esiste nel menu. Per favore, digita una delle opzioni presenti nel menu")
```

## Cercare per autore e anno corrente

- utilizzo datetime: [https://www.w3schools.com/python/python_datetime.asp](https://www.w3schools.com/python/python_datetime.asp)
- inserire prima un volume datato con l’anno corrente, altrimenti non avremo mai nessun risultato

```python
# registro.py
import os
import datetime
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

def cerca_titolo_autore(titolo, autore):
    global collezione
    risultati_ricerca = []
    for indice, libro in collezione.items():
        if libro[0].lower().strip() == titolo.lower().strip():
            # per ogni nome e cognome, controllare le corrispondenze
            nomi_cognomi = autore.split(" ")
            corrispondenza_autore = True
            for n in nomi_cognomi:
                if n not in libro[1].lower().strip():
                    corrispondenza_autore = False
            if corrispondenza_autore:
                risultati_ricerca.append((indice, libro))
    return risultati_ricerca

def cerca_anno_corrente_autore(autore):
    global collezione
    risultati_ricerca = []
    anno_corrente = datetime.datetime.now().year
    for indice, libro in collezione.items():
        if libro[2] == anno_corrente:
            # per ogni nome e cognome, controllare le corrispondenze
            nomi_cognomi = autore.split(" ")
            corrispondenza_autore = True
            for n in nomi_cognomi:
                if n not in libro[1].lower().strip():
                    corrispondenza_autore = False
            if corrispondenza_autore:
                risultati_ricerca.append((indice, libro))
    return risultati_ricerca
```

```python
# main.py
import registro

ripeti = True
while ripeti:
    # menu
    print("Scegli una delle seguenti voci digitando il carattere corrispondente.")
    print("[i] Inserire un nuovo libro.")
    print("[v] Visualizzare la lista dei libri nel registro.")
    print("[m] Modificare una voce nel registro.")
    print("[c] Cerca.")
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

    elif scelta == "c":
        print("Come vorresti cercare?")
        print("[1] Per titolo e autore")
        print("[2] Per anno corrente e autore")
        scelta_cerca = input("Digita la tua scelta tra i caratteri ammessi: ").lower().strip()
        if scelta_cerca == "1":
            titolo_cerca = input("Inserisci il titolo del libro: ")
            autore_cerca = input("Inserisci l'autore del libro: ")
            risultato_ricerca = registro.cerca_titolo_autore(titolo_cerca, autore_cerca)
            if risultato_ricerca:
                for r in risultato_ricerca:
                    print(f"[{r[0]}]: {r[1]}")
            else:
                print("Nessun risultato trovato!")
        elif scelta_cerca == "2":
            autore_cerca = input("Inserisci l'autore del libro: ")
            risultato_ricerca = registro.cerca_anno_corrente_autore(autore_cerca)
            if risultato_ricerca:
                for r in risultato_ricerca:
                    print(f"[{r[0]}]: {r[1]}")
            else:
                print("Nessun risultato trovato!")
    # uscita dal programma
    elif scelta == "e":
        print("Alla prossima!")
        ripeti = False
        registro.salva_collezione()
    else:
        print("Sembra che tu abbia scelto qualcosa che non esiste nel menu. Per favore, digita una delle opzioni presenti nel menu")

```

## Cerca per genere e fascia di prezzo

- valori di default: [https://www.geeksforgeeks.org/default-arguments-in-python/](https://www.geeksforgeeks.org/default-arguments-in-python/)

```python
# registro.py

import os
import datetime
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

def cerca_titolo_autore(titolo, autore):
    global collezione
    risultati_ricerca = []
    for indice, libro in collezione.items():
        if libro[0].lower().strip() == titolo.lower().strip():
            # per ogni nome e cognome, controllare le corrispondenze
            nomi_cognomi = autore.split(" ")
            corrispondenza_autore = True
            for n in nomi_cognomi:
                if n not in libro[1].lower().strip():
                    corrispondenza_autore = False
            if corrispondenza_autore:
                risultati_ricerca.append((indice, libro))
    return risultati_ricerca

def cerca_anno_corrente_autore(autore):
    global collezione
    risultati_ricerca = []
    anno_corrente = datetime.datetime.now().year
    for indice, libro in collezione.items():
        if libro[2] == anno_corrente:
            # per ogni nome e cognome, controllare le corrispondenze
            nomi_cognomi = autore.split(" ")
            corrispondenza_autore = True
            for n in nomi_cognomi:
                if n not in libro[1].lower().strip():
                    corrispondenza_autore = False
            if corrispondenza_autore:
                risultati_ricerca.append((indice, libro))
    return risultati_ricerca

def cerca_genere_prezzo(genere, prezzo_min = None, prezzo_max = None):
    global collezione
    risultati_ricerca = []
    for indice, libro in collezione.items():
        if libro[3].lower().strip() == genere:
            prezzo_compreso = True
            if prezzo_min:
                if libro[4] < float(prezzo_min): prezzo_compreso = False
            if prezzo_max:
                if libro[4] > float(prezzo_max): prezzo_compreso = False
            if prezzo_compreso:
                risultati_ricerca.append((indice, libro))
    return risultati_ricerca
```

```python
# main.py

import registro

ripeti = True
while ripeti:
    # menu
    print("Scegli una delle seguenti voci digitando il carattere corrispondente.")
    print("[i] Inserire un nuovo libro.")
    print("[v] Visualizzare la lista dei libri nel registro.")
    print("[m] Modificare una voce nel registro.")
    print("[c] Cerca.")
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

    elif scelta == "c":
        print("Come vorresti cercare?")
        print("[1] Per titolo e autore")
        print("[2] Per anno corrente e autore")
        print("[3] Per genere e fascia di prezzo")
        scelta_cerca = input("Digita la tua scelta tra i caratteri ammessi: ").lower().strip()
        if scelta_cerca == "1":
            titolo_cerca = input("Inserisci il titolo del libro: ")
            autore_cerca = input("Inserisci l'autore del libro: ")
            risultato_ricerca = registro.cerca_titolo_autore(titolo_cerca, autore_cerca)
            if risultato_ricerca:
                for r in risultato_ricerca:
                    print(f"[{r[0]}]: {r[1]}")
            else:
                print("Nessun risultato trovato!")
        elif scelta_cerca == "2":
            autore_cerca = input("Inserisci l'autore del libro: ")
            risultato_ricerca = registro.cerca_anno_corrente_autore(autore_cerca)
            if risultato_ricerca:
                for r in risultato_ricerca:
                    print(f"[{r[0]}]: {r[1]}")
            else:
                print("Nessun risultato trovato!")
        elif scelta_cerca == "3":
            genere_cerca = input("Inserisci il genere desiderato: ")
            prezzo_min = input("Inserisci il prezzo minimo (premi invio se non desideri inserire una soglia minima): ")
            prezzo_max = input(
                "Inserisci il prezzo massimo (premi invio se non desideri inserire una soglia massima): ")
            if prezzo_min != "":
                try:
                    prezzo_min = float(prezzo_min)
                except:
                    print(
                        "Non hai inserito un numero. Inserisci il prezzo in formato numerico, ad esempio: 14.0")
                    prezzo_min = input(
                        "Inserisci il prezzo minimo (premi invio se non desideri inserire una soglia minima): ")
            if prezzo_max != "":
                try:
                    prezzo_max = float(prezzo_max)
                except:
                    print(
                        "Non hai inserito un numero. Inserisci il prezzo in formato numerico, ad esempio: 14.0")
                    prezzo_max = input(
                        "Inserisci il prezzo massimo (premi invio se non desideri inserire una soglia massima): ")
            risultato_ricerca = registro.cerca_genere_prezzo(genere = genere_cerca, prezzo_min=prezzo_min, prezzo_max = prezzo_max)
            if risultato_ricerca:
                for r in risultato_ricerca:
                    print(f"[{r[0]}]: {r[1]}")
            else:
                print("Nessun risultato trovato!")
    # uscita dal programma
    elif scelta == "e":
        print("Alla prossima!")
        ripeti = False
        registro.salva_collezione()
    else:
        print("Sembra che tu abbia scelto qualcosa che non esiste nel menu. Per favore, digita una delle opzioni presenti nel menu")

```

## Estrai a caso un libro dalla collezione

- pacchetto `random` : [https://www.w3schools.com/python/module_random.asp](https://www.w3schools.com/python/module_random.asp)
- metodo `.keys()` dei dizionari

```python
# registro.py

import os
import datetime
import random
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

def cerca_titolo_autore(titolo, autore):
    global collezione
    risultati_ricerca = []
    for indice, libro in collezione.items():
        if libro[0].lower().strip() == titolo.lower().strip():
            # per ogni nome e cognome, controllare le corrispondenze
            nomi_cognomi = autore.split(" ")
            corrispondenza_autore = True
            for n in nomi_cognomi:
                if n not in libro[1].lower().strip():
                    corrispondenza_autore = False
            if corrispondenza_autore:
                risultati_ricerca.append((indice, libro))
    return risultati_ricerca

def cerca_anno_corrente_autore(autore):
    global collezione
    risultati_ricerca = []
    anno_corrente = datetime.datetime.now().year
    for indice, libro in collezione.items():
        if libro[2] == anno_corrente:
            # per ogni nome e cognome, controllare le corrispondenze
            nomi_cognomi = autore.split(" ")
            corrispondenza_autore = True
            for n in nomi_cognomi:
                if n not in libro[1].lower().strip():
                    corrispondenza_autore = False
            if corrispondenza_autore:
                risultati_ricerca.append((indice, libro))
    return risultati_ricerca

def cerca_genere_prezzo(genere, prezzo_min = None, prezzo_max = None):
    global collezione
    risultati_ricerca = []
    for indice, libro in collezione.items():
        if libro[3].lower().strip() == genere:
            prezzo_compreso = True
            if prezzo_min:
                if libro[4] < float(prezzo_min): prezzo_compreso = False
            if prezzo_max:
                if libro[4] > float(prezzo_max): prezzo_compreso = False
            if prezzo_compreso:
                risultati_ricerca.append((indice, libro))
    return risultati_ricerca

def estrai_libro_a_caso(cambia_prezzo = None):
    global collezione
    indice = random.choice(list(collezione.keys()))
    if cambia_prezzo:
        collezione[indice][4] = cambia_prezzo
    return indice, collezione[indice]
```

```python
# main,py

import registro

ripeti = True
while ripeti:
    # menu
    print("Scegli una delle seguenti voci digitando il carattere corrispondente.")
    print("[i] Inserire un nuovo libro.")
    print("[v] Visualizzare la lista dei libri nel registro.")
    print("[m] Modificare una voce nel registro.")
    print("[c] Cerca.")
    print("[a] Appuntamento al buio.")
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

    elif scelta == "c":
        print("Come vorresti cercare?")
        print("[1] Per titolo e autore")
        print("[2] Per anno corrente e autore")
        print("[3] Per genere e fascia di prezzo")
        scelta_cerca = input("Digita la tua scelta tra i caratteri ammessi: ").lower().strip()
        if scelta_cerca == "1":
            titolo_cerca = input("Inserisci il titolo del libro: ")
            autore_cerca = input("Inserisci l'autore del libro: ")
            risultato_ricerca = registro.cerca_titolo_autore(titolo_cerca, autore_cerca)
            if risultato_ricerca:
                for r in risultato_ricerca:
                    print(f"[{r[0]}]: {r[1]}")
            else:
                print("Nessun risultato trovato!")
        elif scelta_cerca == "2":
            autore_cerca = input("Inserisci l'autore del libro: ")
            risultato_ricerca = registro.cerca_anno_corrente_autore(autore_cerca)
            if risultato_ricerca:
                for r in risultato_ricerca:
                    print(f"[{r[0]}]: {r[1]}")
            else:
                print("Nessun risultato trovato!")
        elif scelta_cerca == "3":
            genere_cerca = input("Inserisci il genere desiderato: ")
            prezzo_min = input("Inserisci il prezzo minimo (premi invio se non desideri inserire una soglia minima): ")
            prezzo_max = input(
                "Inserisci il prezzo massimo (premi invio se non desideri inserire una soglia massima): ")
            if prezzo_min != "":
                try:
                    prezzo_min = float(prezzo_min)
                except:
                    print(
                        "Non hai inserito un numero. Inserisci il prezzo in formato numerico, ad esempio: 14.0")
                    prezzo_min = input(
                        "Inserisci il prezzo minimo (premi invio se non desideri inserire una soglia minima): ")
            if prezzo_max != "":
                try:
                    prezzo_max = float(prezzo_max)
                except:
                    print(
                        "Non hai inserito un numero. Inserisci il prezzo in formato numerico, ad esempio: 14.0")
                    prezzo_max = input(
                        "Inserisci il prezzo massimo (premi invio se non desideri inserire una soglia massima): ")
            risultato_ricerca = registro.cerca_genere_prezzo(genere = genere_cerca, prezzo_min=prezzo_min, prezzo_max = prezzo_max)
            if risultato_ricerca:
                for r in risultato_ricerca:
                    print(f"[{r[0]}]: {r[1]}")
            else:
                print("Nessun risultato trovato!")

    elif scelta == "a":
        cambia_prezzo = input("Nuovo prezzo (premi invio se non vuoi modificarlo): ")
        if cambia_prezzo != "":
            try:
                cambia_prezzo = float(cambia_prezzo)
            except:
                print(
                    "Non hai inserito un numero. Inserisci il prezzo in formato numerico, ad esempio: 14.0")
                cambia_prezzo = input(
                    "Inserisci il nuovo prezzo (premi invio se non desideri inserire una soglia massima): ")
        risultato_indice, risultato_libro = registro.estrai_libro_a_caso(cambia_prezzo)
        print(f"Libro estratto: [{risultato_indice}] {risultato_libro}")
    # uscita dal programma
    elif scelta == "e":
        print("Alla prossima!")
        ripeti = False
        registro.salva_collezione()
    else:
        print("Sembra che tu abbia scelto qualcosa che non esiste nel menu. Per favore, digita una delle opzioni presenti nel menu")

```

## Acquistare un libro

- raise exceptions: [https://www.w3schools.com/python/gloss_python_raise.asp](https://www.w3schools.com/python/gloss_python_raise.asp)
- `datetime.datetime.now().strftime("%d%m%Y")` : [https://www.w3schools.com/python/python_datetime.asp](https://www.w3schools.com/python/python_datetime.asp)

```python
# registro.py

import os
import datetime
import random
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
    print("File di salvataggio collezione non trovato")
    collezione = {}

try:
    with open(os.path.join("data","cassa.pkl"), "rb") as file:
        cassa = pickle.load(file)
except:
    print("File di salvataggio cassa non trovato")
    cassa = {}

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

def cerca_titolo_autore(titolo, autore):
    global collezione
    risultati_ricerca = []
    for indice, libro in collezione.items():
        if libro[0].lower().strip() == titolo.lower().strip():
            # per ogni nome e cognome, controllare le corrispondenze
            nomi_cognomi = autore.split(" ")
            corrispondenza_autore = True
            for n in nomi_cognomi:
                if n not in libro[1].lower().strip():
                    corrispondenza_autore = False
            if corrispondenza_autore:
                risultati_ricerca.append((indice, libro))
    return risultati_ricerca

def cerca_anno_corrente_autore(autore):
    global collezione
    risultati_ricerca = []
    anno_corrente = datetime.datetime.now().year
    for indice, libro in collezione.items():
        if libro[2] == anno_corrente:
            # per ogni nome e cognome, controllare le corrispondenze
            nomi_cognomi = autore.split(" ")
            corrispondenza_autore = True
            for n in nomi_cognomi:
                if n not in libro[1].lower().strip():
                    corrispondenza_autore = False
            if corrispondenza_autore:
                risultati_ricerca.append((indice, libro))
    return risultati_ricerca

def cerca_genere_prezzo(genere, prezzo_min = None, prezzo_max = None):
    global collezione
    risultati_ricerca = []
    for indice, libro in collezione.items():
        if libro[3].lower().strip() == genere:
            prezzo_compreso = True
            if prezzo_min:
                if libro[4] < float(prezzo_min): prezzo_compreso = False
            if prezzo_max:
                if libro[4] > float(prezzo_max): prezzo_compreso = False
            if prezzo_compreso:
                risultati_ricerca.append((indice, libro))
    return risultati_ricerca

def estrai_libro_a_caso(cambia_prezzo = None):
    global collezione
    indice = random.choice(list(collezione.keys()))
    if cambia_prezzo:
        collezione[indice][4] = cambia_prezzo
    return indice, collezione[indice]

def aggiungi_vendita(codice, quantita = 1):
    global cassa, collezione
    if collezione[codice][5] - quantita < 0:
        raise Exception("Non ci sono abbastanza volumi!")
    data = datetime.datetime.now().strftime("%d%m%Y")
    if data not in cassa.keys():
        cassa[data] = []
    cassa[data].append((collezione[codice], quantita))
    collezione[codice][5] = collezione[codice][5] - quantita

def calcola_rendita_di_oggi():
    global cassa
    totale = 0
    for vendita in cassa[datetime.datetime.now().strftime("%d%m%Y")]:
        totale += vendita[0][4] * vendita[1]
    return totale

def salva_cassa():
    global cassa
    if not os.path.exists("data"):
        os.makedirs("data")
    with open(os.path.join("data", "cassa.pkl"), "wb") as file:
        pickle.dump(cassa, file)
```

```python
# main.py

import registro

ripeti = True
while ripeti:
    # menu
    print("Scegli una delle seguenti voci digitando il carattere corrispondente.")
    print("[i] Inserire un nuovo libro.")
    print("[v] Visualizzare la lista dei libri nel registro.")
    print("[m] Modificare una voce nel registro.")
    print("[c] Cerca.")
    print("[a] Appuntamento al buio.")
    print("[s] Vendi libri")
    print("[vc] Visualizza cassa.")
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

    elif scelta == "c":
        print("Come vorresti cercare?")
        print("[1] Per titolo e autore")
        print("[2] Per anno corrente e autore")
        print("[3] Per genere e fascia di prezzo")
        scelta_cerca = input("Digita la tua scelta tra i caratteri ammessi: ").lower().strip()
        if scelta_cerca == "1":
            titolo_cerca = input("Inserisci il titolo del libro: ")
            autore_cerca = input("Inserisci l'autore del libro: ")
            risultato_ricerca = registro.cerca_titolo_autore(titolo_cerca, autore_cerca)
            if risultato_ricerca:
                for r in risultato_ricerca:
                    print(f"[{r[0]}]: {r[1]}")
            else:
                print("Nessun risultato trovato!")
        elif scelta_cerca == "2":
            autore_cerca = input("Inserisci l'autore del libro: ")
            risultato_ricerca = registro.cerca_anno_corrente_autore(autore_cerca)
            if risultato_ricerca:
                for r in risultato_ricerca:
                    print(f"[{r[0]}]: {r[1]}")
            else:
                print("Nessun risultato trovato!")
        elif scelta_cerca == "3":
            genere_cerca = input("Inserisci il genere desiderato: ")
            prezzo_min = input("Inserisci il prezzo minimo (premi invio se non desideri inserire una soglia minima): ")
            prezzo_max = input(
                "Inserisci il prezzo massimo (premi invio se non desideri inserire una soglia massima): ")
            if prezzo_min != "":
                try:
                    prezzo_min = float(prezzo_min)
                except:
                    print(
                        "Non hai inserito un numero. Inserisci il prezzo in formato numerico, ad esempio: 14.0")
                    prezzo_min = input(
                        "Inserisci il prezzo minimo (premi invio se non desideri inserire una soglia minima): ")
            if prezzo_max != "":
                try:
                    prezzo_max = float(prezzo_max)
                except:
                    print(
                        "Non hai inserito un numero. Inserisci il prezzo in formato numerico, ad esempio: 14.0")
                    prezzo_max = input(
                        "Inserisci il prezzo massimo (premi invio se non desideri inserire una soglia massima): ")
            risultato_ricerca = registro.cerca_genere_prezzo(genere = genere_cerca, prezzo_min=prezzo_min, prezzo_max = prezzo_max)
            if risultato_ricerca:
                for r in risultato_ricerca:
                    print(f"[{r[0]}]: {r[1]}")
            else:
                print("Nessun risultato trovato!")

    elif scelta == "a":
        cambia_prezzo = input("Nuovo prezzo (premi invio se non vuoi modificarlo): ")
        if cambia_prezzo != "":
            try:
                cambia_prezzo = float(cambia_prezzo)
            except:
                print(
                    "Non hai inserito un numero. Inserisci il prezzo in formato numerico, ad esempio: 14.0")
                cambia_prezzo = input(
                    "Inserisci il nuovo prezzo (premi invio se non desideri inserire una soglia massima): ")
        risultato_indice, risultato_libro = registro.estrai_libro_a_caso(cambia_prezzo)
        print(f"Libro estratto: [{risultato_indice}] {risultato_libro}")

    elif scelta == "s":
        print("Che libro devi vendere?")
        registro.stampa_collezione_con_codice()
        #todo aggiungere controlli
        codice_libro_da_vendere = int(input("Scegli un codice: "))
        quantita_da_vendere = int(input("Quanti ne devi vendere? Scrivi un numero intero: "))
        registro.aggiungi_vendita(codice_libro_da_vendere, quantita_da_vendere)
        rendita = registro.calcola_rendita_di_oggi()
        print(f"Per oggi hai guadagnato: {rendita}")

    elif scelta == "vc":
        print(registro.cassa)

    # uscita dal programma
    elif scelta == "e":
        print("Alla prossima!")
        ripeti = False
        registro.salva_collezione()
        registro.salva_cassa()
    else:
        print("Sembra che tu abbia scelto qualcosa che non esiste nel menu. Per favore, digita una delle opzioni presenti nel menu")

```