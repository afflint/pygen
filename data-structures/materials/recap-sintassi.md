# Recap sintassi

# String slicing

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

# Funzioni

```python
def nome_funzione(argomento1, argomento2):
	#corpo funzione
	return # non sempre necessario
```

# Tuple

```python
myTuple = (elem1, elem2, elem3)
# accedere al n-esimo elemento, n è un indice intero
myTuple[n] # lo slicing è uguale a quello delle stringhe
```

# List

```python
myList = [elem1, elem2, elem3]
# accedere al n-esimo elemento, n è un indice intero
myList[n] # lo slicing è uguale a quello delle stringhe
```

# While

```python
while condizione:
	# istruzioni da ripetere
```

# For

```python
	for elemento in struttura_dati_sequenziale:
		# istruzioni da ripetere per ogni elemento
```

# If-elif-else

Ricorda: sia `elif` sia `else` sono opzioinali!

```python
if condizione1:
	# istruzioni da eseguire se condizione1 è True
elif condizione2:
	# istruzioni da eseguire se condizione1 è False e condizione2 è True
# tanti elif quanti ne vuoi
else:
	# istruzioni da eseguire se nessuna condizione è a True
```

# Dict

```python
myDict = {chiave1: valore1, chiave2, valore2}
# aggiungere una nuova voce
myDict[nuova_chiave] = nuovo_valore
# se nuova_chiave esiste già, allora nuovo_valore sovrascrive il vecchio valore
```