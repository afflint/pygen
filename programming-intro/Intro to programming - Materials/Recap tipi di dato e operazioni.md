# Recap tipi di dato e operazioni

# Tipi di dato

Ogni linguaggio di programmazione offre al programmatore dei tipi di dato predefiniti. Concentriamoci sui tipi predefiniti offerti da Python (vedremo solo ciò che ci serve).

- Tipi numerici
    - `int` : 0, 3, -5, 399, 37555, …
    - `float` : 0.5, 4.6782, 2993.45, …
- Tipo testuali
    - `str` : “Hello world!”
- Tipo booleano
    - `bool`: True (→ 1), False (→ 0)
- Tipo vuoto
    - `NoneType` : None
- Tipi sequenziali, insiemistici, chiave-valore: li affronteremo la prossima volta!
    - `list` : [1, 3, “pizza”, None, 5.7, False]
    - `tuple` : (1, 3, “pizza”, None, 5.7, False)
    - `set` : {1, 3, “pizza”, None, 5.7, False}
    - `dict` : {1: “ciao”, “due” : None}

# Operazioni

Le operazioni che possiamo eseguire con i dati dipendono dal tipo dei dati stessi. Ora vedremo solo quali operazioni possono essere eseguite, in seguito le proveremo in Python.

## **Operatori per tipi numerici**

| Operatore | Descrizione | Esempio |
| --- | --- | --- |
| + | Addizione | 12 + 10 -> 22 |
| - | Sottrazione | 12 - 10 -> 12 |
| * | Moltiplicazione | 12 * 10 -> 120 |
| / | Divisione | 12 / 10 -> 1,2 |
| // | Divisione intera | 12 // 10 -> 1 |
| % | Modulo (resto della divisione) | 12 % 10 -> 2 |
| == | Uguaglianza | 1 == 1 -> True |
| != | Disuguaglianza | 1 != 1 -> False |

## **Operatori per tipi testuali**

| Operatore | Descrizione | Esempio |
| --- | --- | --- |
| + | Concatenazione | “hello” + “world” -> “helloworld” |
| * | Ripetizione | “hello” * 2 -> “hellohello” |
| == | Uguaglianza | “hello” == “hello” -> True |
| != | Disuguaglianza | “hello” != “hello” -> False |
| in | Appartenenza | “hello” in “hello world” -> True |
| not in | Non appartenenza | “hello” not in “hello world” -> False |

## **Operatori booleani**

| Operatore | Descrizione | Esempio |
| --- | --- | --- |
| and | True se entrambi gli operandi sono True | True and True -> True, True and False -> False |
| or | True se almeno uno degli operandi è True | True and False -> True, False and False -> False |
| not | True se l’operando è False, False se l’operando è True | not False -> True, not True -> False |

Curiosità: ogni tipo di dato può essere codificato come `True` o `False`. Ad esempio:

- il numero `0` corrisponde a `False`, mentre qualsiasi altro numero corrisponde a `True`;
- un testo vuoto `“”` corrisponde a `False`, mentre qualsiasi altro testo corrisponde a `True`;
- `None` corrisponde sempre a `False`.
