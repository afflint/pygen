# Comandi usati durante la lezione

# Operazioni di base

Aprire l’interprete python da terminale

```bash
python
```

Operazioni (da terminale)

```python
1+1
1/0
print("Ciao Mondo!")
```

# Primo script

Primo script python (`main.py` e `script.py` successivamente)

```python
# main.py

# prima versione
print("Ciao Mondo!")

# seconda versione
print("Ciao Mondo!")
1+1

# terza versione
print("Ciao Mondo!")
print(1+1)

# quarta versione
print("Ciao Mondo!")
print(1+1

# quinta versione
print("Ciao Mondo!")
print(1+1)
1/0
```

Eseguire `script.py` da terminale

```bash
python script.py
```

# Variabili

Esempio di creazione variabile

```python
myNum = 15
myNum = "15" # nessun errore!
```

# Programmazione modulare

Esempio di codice scritto senza la programmazione modulare

```python
# main.py

# Informazioni del primo libro
titolo1 = "Il Signore degli Anelli"
autore1 = "J.R.R. Tolkien"
prezzo1 = 20.0
quantita1 = 3

# Informazioni del secondo libro
titolo2 = "1984"
autore2 = "George Orwell"
prezzo2 = 15.0
quantita2 = 5

# Calcolo del prezzo totale con sconto
sconto = 0.10
prezzo_totale1 = prezzo1 * quantita1 * (1 - sconto)
prezzo_totale2 = prezzo2 * quantita2 * (1 - sconto)
prezzo_totale = prezzo_totale1 + prezzo_totale2

# Formattazione delle informazioni del primo libro
info_libro1 = f"{titolo1} di {autore1} - Prezzo: €{prezzo1}, Quantità: {quantita1}, Totale con sconto: €{prezzo_totale1}"
print(info_libro1)

# Formattazione delle informazioni del secondo libro
info_libro2 = f"{titolo2} di {autore2} - Prezzo: €{prezzo2}, Quantità: {quantita2}, Totale con sconto: €{prezzo_totale2}"
print(info_libro2)

# Stampa del prezzo totale dell'inventario
print(f"Prezzo totale dell'inventario con sconto: €{prezzo_totale}")

```

## Funzioni

Esempio di funzione e come richiamarla

```python
def saluta():
	print("Ciao")
	
def saluta_nome(nome):
	nome = " " + nome
	print("Ciao" + nome)
	
def area_rettangolo(lato1, lato2):
	area = lato1 * lato2
	return area
	
saluta()
saluta_nome("Elisabetta")
larghezza = 2
lunghezza = 4
area = area_rettangolo(larghezza, lunghezza) 
```

## String slicing

```python
testo = "Hello, World!"

# Estrai i primi 5 caratteri
sottostringa = testo[:5]
print(sottostringa)

# Estrai i caratteri dalla posizione 7 alla fine
print(testo[7:])

# Estrai i caratteri dalla posizione 7 alla posizione 11 compresa
print(testo[7:12])

testo = "abcdefg"
# Estrai un carattere ogni 2
print(testo[::2])

# Estrai la stringa al contrario
print(testo[::-1])

# Estrai la stringa al contrario, selezionando un carattere ogni 2
print(testo[::-2])

# Estrai i caratteri dalla posizione 4 alla posizione 10 (non compresa), 
# selezionando un carattere ogni 3
print(testo[4:10:3])
```

## Funzioni per stringhe

```python
testo = "Hello, World!"

# Converte tutti i caratteri in minuscolo
testo_minuscolo = testo.lower()
print(testo_minuscolo)

# Converte tutti i caratteri in maiuscolo
print(testo.upper())

# Sostituisce tutte le occorrenze di 'World' con 'Python'
print(testo.replace("World", "Python"))

testo = "   Hello, World!     "
# Rimuove gli spazi all'inizio e alla fine
print(testo.strip())
```

## Moduli

File `utils.py`.

```python
# utils.py

nome_libreria = "Libreria Generali"
n_libri_di_prova = 2

def informazioni_libro1():
    """Restituisce le informazioni del primo libro."""
    titolo = "Il Signore degli Anelli"
    autore = "J.R.R. Tolkien"
    prezzo = 20.0
    quantita = 3
    return titolo, autore, prezzo, quantita

def informazioni_libro2():
    """Restituisce le informazioni del secondo libro."""
    titolo = "1984"
    autore = "George Orwell"
    prezzo = 15.0
    quantita = 5
    return titolo, autore, prezzo, quantita

def calcola_prezzo_totale(prezzo, quantita, sconto=0.10):
    """Calcola il prezzo totale con sconto."""
    return prezzo * quantita * (1 - sconto)

def formatta_info_libro(titolo, autore, prezzo, quantita, prezzo_totale):
    """Formatta le informazioni di un libro per la visualizzazione."""
    return f"{titolo} di {autore} - Prezzo: €{prezzo}, Quantità: {quantita}, Totale con sconto: €{prezzo_totale}"
```

Importare il modulo in un altro script.

```python
# tutto il modulo
import utils
```

File `main.py`.

```python
# versione 1
print("\n".join(dir()))

# versione 2
import utils
print("\n".join(dir()))

# versione 3
import utils
print(utils.nome_libreria)

# versione 4
from utils import nome_libreria
print("\n".join(dir()))
print(nome_libreria)

# versione 5
from utils import *
print("\n".join(dir()))
```

Altri modi per importare

```python
# una funzione dal modulo
from utils import nome_libreria
# tutto da un modulo
from utils import *
# più cose da un modulo
from utils import nome_libreria, calcola_prezzo_totale
# rinominare ciò che si importa
import utils as utl #tutto il modulo
from utils import nome_libreria as nl #solo una cosa
```

Versione finale `main.py`

```python
# main.py

from utils import \
    informazioni_libro1, \
    informazioni_libro2, \
    calcola_prezzo_totale, \
    formatta_info_libro

# Ottieni le informazioni del primo libro
titolo1, autore1, prezzo1, quantita1 = informazioni_libro1()
prezzo_totale1 = calcola_prezzo_totale(prezzo1, quantita1)
info_libro1 = formatta_info_libro(titolo1, autore1, prezzo1, quantita1, prezzo_totale1)

# Ottieni le informazioni del secondo libro
titolo2, autore2, prezzo2, quantita2 = informazioni_libro2()
prezzo_totale2 = calcola_prezzo_totale(prezzo2, quantita2)
info_libro2 = formatta_info_libro(titolo2, autore2, prezzo2, quantita2, prezzo_totale2)

# Calcola il prezzo totale dell'inventario
prezzo_totale_inventario = prezzo_totale1 + prezzo_totale2

# Stampa le informazioni dei libri
print("Inventario dei Libri:")
print(info_libro1)
print(info_libro2)
print(f"Prezzo totale dell'inventario con sconto: €{prezzo_totale_inventario:}")
```

## Pacchetti

Controllare le cartelle visibili correntemente dall’interprete.

```python
import sys
print(sys.path)
```

Aggiungere cartelle visibili

```python
sys.path.append(<path_to_dir>)
```

## Installare pacchetti

Esempio con `numpy`  (da eseguire nel terminale).

```bash
pip install numpy
```

## Creare Virtual Environments a mano

Da eseguire nel terminale: creazione del virtual environment.

```bash
virtualenv venv-progetto
```

Da eseguire nel terminale: attivazione del virtual environment (MAC)

```bash
source venv-progetto/bin/activate
```

WINDOWS

```bash
.\venv-progetto\Scripts\activate
```

Disattivare un virtual environment

```bash
deactivate
```

Creare un virtual environment con una specifica versione di python

```bash
virtualenv --python <path/to/python> <path_or_name/to/new/venv>
```

# Debugging

Codice da debuggare

```python
def divide(a, b):
    return a / b

def calculate(x, y):
    return divide(x + y, y - x)

# Valori di input
num1 = 5
num2 = 5

# Calcola e stampa il risultato
result = calculate(num1, num2)
print("Il risultato è:", result)

```

Aggiungere i print

```python
def divide(a, b):
    print(f"L'input della funzione divide è num1 = {a} e num2 = {b}")
    return a / b

def calculate(x, y):
    print(f"L'input della funzione calculate è num1 = {x} e num2 = {y}")
    return divide(x + y, y - x)

# Valori di input
num1 = 5
num2 = 5

print(f"L'input è num1 = {num1} e num2 = {num2}")

# Calcola e stampa il risultato
result = calculate(num1, num2)
print("Il risultato è:", result)

```

# Jupyter Notebooks

Installazione dello strumento `notebook` (da eseguire nel terminale):

```bash
pip install notebook
```

Avviare l’ambiente notebook (da eseguire nel terminale)

```bash
jupyter notebook
```

Codice da scrivere nelle celle del notebook 

```python
print("Hello, world!")
```

## Sintassi markdown

```markdown
# Titolo 1
## Titolo 2
### Titolo 3
#### Titolo 4
##### Titolo 5
###### Titolo 6
```

```markdown
**testo in grassetto** o __testo in grassetto__
*testo in corsivo* o _testo in corsivo_
~~testo barrato~~
```

```markdown
- Elemento 1
- Elemento 2
  - Sottoelemento 2.1
  - Sottoelemento 2.2

1. Elemento 1
2. Elemento 2
   1. Sottoelemento 2.1
   2. Sottoelemento 2.2

```

```markdown
[Google](https://www.google.com)
```

```markdown
![Python Logo](https://www.python.org/static/community_logos/python-logo.png)
```

```markdown
Questo è un `codice in linea`.
```

```markdown
| Colonna 1 | Colonna 2 |
|-----------|-----------|
| Valore 1  | Valore 2  |
| Valore 3  | Valore 4  |
```

```markdown
Questo è un esempio di equazione in linea: $E = mc^2$

$$
E = mc^2
$$

```