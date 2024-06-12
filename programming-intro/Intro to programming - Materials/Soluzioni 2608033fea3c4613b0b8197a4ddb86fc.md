# Soluzioni

# Operazioni di base

## Esercizio 1

Scrivi un programma Python che stampi il risultato delle seguenti operazioni aritmetiche: 5 + 3; 7*8; 50-10; 144/12.

```python
# Esercizio 1
print(5 + 3)
print(7 * 8)
print(50 - 10)
print(144 / 12)
```

## Esercizio 2

Scrivi un programma Python che stampi il risultato della concatenazione di varie *stringhe*: “Hello” e “world!”; “Python” e “is” e “fun!”; la ripetizione di “Ha” tre volte; “I was born in” e il tuo anno di nascita. Nota che la concatenazione tra stringa e numero richiede la conversione del numero in stringa con il comando `str()` . Perciò, scriveremo `str(1234)` per convertire il numero 1234 in stringa.

```python
# Esercizio 2
print("Hello, " + "world!")
print("Python " + "is " + "fun!")
print("Ha" * 3)
print("I was born in " + str(1998))
```

# Variabili

Proviamo a riscrivere i due esercizi di prima utilizzando delle variabili. Ad esempio, l’istruzione `print(5 + 3)` può essere riscritta

```python
numero1 = 5
numero2 = 3
risultato = numero1 + numero2
print(risultato)
"""
è possibile effettuare ogni combinazione che prevede l'uso del 
valore senza dichiarare una nuova variabile e l'uso della variabile
"""
```

```python
# Esercizio 1
numero1 = 5
numero2 = 3
risultato = numero1 + numero2
print(risultato)

numero1 = 7
print(numero1 * 8)

numero1, numero2 = 50, 10
print(numero1 - numero2)

numero2 = 12
risultato = 144 / numero2
print(risultato)

# Esercizio 2
stringa1, stringa2 = "Hello, ", "world!"
print(stringa1 + stringa2)

stringa1 = "Python "
stringa2 = "is "
risultato = stringa1 + stringa2
risultato += "fun!"
print(risultato)

stringa1 = "Ha" * 3
print(risultato)

stringa_numero = str(1998)
print("I was born in " + stringa_numero)
```

# Funzioni

## Esercizio 1

**Calcolo dell'area di un rettangolo**

Scrivi una funzione che calcola l'area di un rettangolo data la lunghezza e la larghezza.

```python
def area_rettangolo(lunghezza, larghezza):
	return lunghezza * larghezza
	
lunghezza = 5.0
larghezza = 3.0

area = area_rettangolo(lunghezza, larghezza)

print(f"L'area del rettangolo è: {area}")
```

## **Esercizio 2**

**Somma di numeri**

Scrivi una funzione che calcola la somma di tre numeri.

```python
def somma_3_numeri(numero1, numero2, numero3):
	somma = numero1 + numero2 + numero3
	return somma
	
n1, n2, n3 = 1.5, 2.0, 3.7

somma = somma_3_numeri(n1, n2, n3)

print(f"La somma dei numeri è: {somma}")
```

## Esercizio 3

**Controllo di palindromi**

Scrivi una funzione che controlla se una parola è un palindromo.

```python
def palindromo(parola):
	parola = parola.lower()
	return parola == parola[::-1]

testo = "Radar"

risultato = palindromo(testo)

print(f"La parola '{parola}' è palindromo: {risultato}")
```